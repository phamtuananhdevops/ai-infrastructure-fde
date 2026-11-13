# Lab 03 — CPU Quota and Throttling (cgroup v2)

**Date documented:** 2026-11-13  
**Environment:** WSL2 Linux, Docker Engine 29.3.0, cgroup v2, 14 logical CPUs  
**Status:** CPU throttling reproduced and verified in an isolated, short-lived container. Application latency impact and host/container side-by-side benchmark are **not yet measured**.

## Objective

Demonstrate that a container can exhaust its own CPU quota and be throttled even when the host has idle CPU capacity. Practice gathering evidence from cgroup v2 instead of assuming that a large process or a slow application necessarily indicates host resource exhaustion.

## Baseline and environment

- `nproc` returned `14`.
- Previous host observations showed low CPU pressure; the WSL2 machine was operating normally. This was a **controlled experiment**, not a production incident.
- `docker info --format '{{.CgroupVersion}}'` returned `2`.
- `docker version --format '{{.Server.Version}}'` returned `29.3.0`.
- Existing local image: `postgres:16-alpine`; reused solely as a shell environment. The experiment did not start a PostgreSQL server.

## CPU quota configuration

A disposable container was started with `--cpus 0.5 --memory 128m --network none`.

Command:

```bash
docker run --rm --network none \
  --memory 128m --cpus 0.5 \
  --entrypoint /bin/sh postgres:16-alpine \
  -c 'echo "Lab environment ready"; cat /sys/fs/cgroup/cpu.max'
```

Observed output:

```text
Lab environment ready
50000 100000
```

In cgroup v2, `cpu.max` contains **quota** and **period**, both in microseconds. Here the group may consume up to **50,000 µs of aggregate CPU time** per **100,000 µs wall-clock period** (50 ms of CPU time per 100 ms period), equivalent to **0.5 CPU**. This is a CPU-time budget, not a dedicated physical half-core. Multiple runnable threads may consume the aggregate quota faster.

## Controlled experiment

The container had no network access, a 128 MiB memory cap, and a 0.5 CPU cap. A CPU-bound shell loop ran under `timeout 12`, followed by a second cgroup measurement.

```bash
docker run --rm --network none \
  --memory 128m --cpus 0.5 \
  --entrypoint /bin/sh postgres:16-alpine \
  -c '
    echo "=== BEFORE ==="
    cat /sys/fs/cgroup/cpu.stat
    timeout 12 sh -c "while :; do :; done" || true
    echo "=== AFTER ==="
    cat /sys/fs/cgroup/cpu.stat
  '
```

Observed `cpu.stat`:

```text
=== BEFORE ===
usage_usec 60483
user_usec 38882
system_usec 21601
nr_periods 1
nr_throttled 0
throttled_usec 0
nr_bursts 0
burst_usec 0
Terminated
=== AFTER ===
usage_usec 6108076
user_usec 6068947
system_usec 39129
nr_periods 122
nr_throttled 120
throttled_usec 5992696
nr_bursts 0
burst_usec 0
```

| Metric | Before | After | Delta |
|---|---:|---:|---:|
| `usage_usec` | 60,483 | 6,108,076 | 6,047,593 µs |
| `nr_periods` | 1 | 122 | 121 |
| `nr_throttled` | 0 | 120 | 120 |
| `throttled_usec` | 0 | 5,992,696 | 5,992,696 µs |

**Analysis:**

- **120 of 121 newly recorded periods** were throttled (approximately **99.2%**). This is the fraction of periods with throttling, **not** CPU utilization.
- The group used approximately **6.05 seconds of CPU time** over a roughly **12-second CPU-bound workload**, consistent with a 0.5 CPU limit.
- The rise in `throttled_usec` provides additional evidence that tasks were constrained by quota. It is a cgroup throttling-time counter and should not be interpreted as application response-time delay.
- The `Terminated` message is expected when `timeout` stops the busy loop; the record does not show an OOM kill.

## Root-cause explanation

The container continuously requested CPU time but its cgroup had only a 0.5 CPU budget. Once that budget was exhausted during a scheduling period, the kernel throttled execution until the next period replenished the quota. Idle logical CPUs on the host **do not override** an explicit cgroup CPU quota. This is **confirmed for the synthetic workload**, not evidence that a real service was slow.

## Lessons learned

1. **Host CPU utilization and container CPU throttling are different signals.** A quiet host can still run a quota-constrained container.
2. **Usage, limit and throttling are distinct:** observed demand below quota generally does not cause quota throttling; sustained demand exceeding quota does.
3. **Read the counters before changing limits.** `cpu.max`, `nr_throttled`, `nr_periods`, and `throttled_usec` help validate the hypothesis.
4. **CPU limits are time budgets.** A 0.5 CPU limit corresponds to 50 ms aggregate CPU time per 100 ms period in this setup.
5. **Avoid overstating the result.** CPU throttling was demonstrated, but no actual application response-time regression was benchmarked.

## Isolation and cleanup

- `--network none` disabled container networking.
- `--memory 128m` and `--cpus 0.5` bounded resources.
- `timeout 12` terminated the workload; `--rm` removed the temporary container.
- Existing OpenSearch, Kafka, Kubernetes, and PostgreSQL services were not intentionally modified.

## Next exercise (not completed)

Compare the same workload with `--cpus 1` and measure host CPU plus cgroup counters under each limit. Then benchmark a test application's response latency at both limits. Only after gathering that evidence should the report make claims about application-level speed or remediation effectiveness.

**Lab result:** **PASS — CPU throttling reproduced with measured cgroup evidence.** Broader Linux & Networking assessment remains separate and ungraded.
