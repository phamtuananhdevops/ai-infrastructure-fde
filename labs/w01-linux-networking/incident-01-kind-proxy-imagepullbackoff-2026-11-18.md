# Incident 01: kind worker ImagePullBackOff after WSL proxy IP change

**Date:** 2026-11-18  
**Lab environment:** WSL2 Ubuntu, Docker, multi-node kind Kubernetes  
**Namespace / workload:** `fde-warroom` / `orders-api` (`nginx:alpine`, 2 replicas)  
**Outcome:** Image pull and Pod readiness recovered; HTTP Service troubleshooting is a separate, still-open exercise  
**Evidence source:** Commands and outputs provided by the learner during a supervised hands-on session

## Incident summary

Both `orders-api` Pods were stuck in `ImagePullBackOff` and could not start. The failure was **not** caused by the application's Service port configuration. Kubelet reported failure to contact the configured HTTP proxy while pulling `docker.io/library/nginx:alpine`.

## Evidence and timeline

| Investigation | Observed evidence | Conclusion |
|---|---|---|
| `kubectl describe pod ...` Events | `proxyconnect tcp: dial tcp <stale-proxy-ip>:3128: connect: connection refused` | Image pull blocked before Docker Hub could be reached |
| WSL `env`, `getent ahostsv4 wsl-proxy` | Host resolved `wsl-proxy` to a *different* current private IPv4 address | IP previously recorded by kind was stale |
| `docker inspect k8s-local-worker` | Worker `HTTP_PROXY`/`HTTPS_PROXY` pointed to `<stale-proxy-ip>:3128` | Node configuration differed from current WSL resolution |
| `docker exec ... getent ahostsv4 wsl-proxy` | No result | Kind worker could not rely on the host-only `wsl-proxy` DNS name |
| Worker TCP test to current proxy IP | `TCP CONNECTED` | Proxy TCP endpoint reachable from worker |
| Worker `curl -Iv --proxy ... https://registry-1.docker.io/v2/` | HTTP CONNECT 200, TLS certificate verified, registry HTTP 401 | End-to-end proxy → HTTPS registry path working; unauthenticated `/v2/` may return 401 normally |
| `/proc/$(pidof containerd)/environ` | Runtime process initially had `<stale-proxy-ip>:3128` | Correct process to reconfigure was `containerd` inside the kind node |
| `systemctl show containerd -p Environment` and runtime `/proc/.../environ` after change | Both showed `<current-proxy-ip>:3128`; original `NO_PROXY` was retained | New proxy settings active in systemd and the running runtime |
| `kubectl -n fde-warroom get pods -o wide` | Both Pods `1/1 Running`, `0` restarts | Image pull and Pod readiness recovered |

An earlier `kubectl rollout status ... --timeout=120s` reported `ProgressDeadlineExceeded`, but a subsequent Pod check showed both Pods healthy. The controller's earlier timeout did not prove the proxy fix failed.

## Confirmed cause vs. inferred cause

- **Confirmed immediate cause:** The running worker's `containerd` used a proxy endpoint that refused TCP connections; image pulls failed.
- **Likely underlying cause:** `set-proxy.sh` captured the `wsl-proxy` IPv4 at one point in time. After the WSL networking/proxy endpoint changed, the previously created kind node and its running `containerd` still had the old IP. The exact origin and time of the IP change were not observed directly.
- **Important distinction:** Sourcing a shell script updates the current WSL shell, **not** already-running Docker containers or `containerd` processes inside kind nodes.

## Recovery performed

1. Resolve current `wsl-proxy` IPv4 on WSL.
2. Confirm the kind worker can reach `http://<current-proxy-ip>:3128` and Docker Registry through that proxy.
3. Add a `containerd.service` systemd drop-in with the current `HTTP_PROXY`/`HTTPS_PROXY` values; retain existing `NO_PROXY`.
4. Reload systemd and ensure the running containerd process has the updated environment (a service restart is required to take new settings into the process).
5. Confirm both previously failing Pods are `Running` and `Ready 1/1`.

## Durable remediation script

The original `set-proxy.sh` only exported proxy environment variables. It was useful for **new** Docker/kind commands but did not fix existing kind nodes. The upgraded approach separates two responsibilities:

- [`set-proxy.sh`](../../scripts/wsl-kind-proxy/set-proxy.sh): `source` this to refresh the WSL shell's proxy using the **current** IPv4 of `wsl-proxy`, while preserving `NO_PROXY`.
- [`sync-kind-containerd-proxy.sh`](../../scripts/wsl-kind-proxy/sync-kind-containerd-proxy.sh): read-only `--check` by default. `--apply` writes a systemd drop-in but does not restart anything. `--restart` explicitly writes the drop-in and restarts `containerd` inside an identified kind node, checks the running environment, and ensures `NO_PROXY` is unchanged.

```bash
# From the repository root, on a self-managed WSL/kind lab:
source scripts/wsl-kind-proxy/set-proxy.sh
bash scripts/wsl-kind-proxy/sync-kind-containerd-proxy.sh --check

# Only after reviewing the impact of restarting containerd:
bash scripts/wsl-kind-proxy/sync-kind-containerd-proxy.sh --restart \
  --node k8s-local-worker

kubectl -n fde-warroom get pods -o wide
```

### Safeguards and limitations

- The sync tool checks the Docker container has a kind cluster label before any mutation; it is not designed for production clusters.
- A restart can interrupt other lab workloads; it is **never automatic** during `--check` or `--apply`.
- The script resolves IP dynamically **when invoked**. It does **not** run itself after every WSL reboot; rerun it if the proxy IP changes, or wire it into an approved local startup process later.
- It updates a selected kind node, not all nodes in a cluster. Repeat for other affected nodes as needed.
- The script is committed as a **reviewed proposal**, syntax-checked off-target; it has **not yet been run against the user's WSL machine**. The recovery above was confirmed using manually executed commands.
- The test registry endpoint's unauthenticated `401` is expected, but this check alone does not guarantee all image registries or artifact downloads will work.

## Acceptance criteria

- [x] Identify image-pull error from Kubernetes Events
- [x] Isolate stale `containerd` proxy environment
- [x] Validate current proxy via worker TCP / HTTPS / TLS / registry response
- [x] Confirm two Pods recovered to `Running`, `Ready 1/1`
- [x] Preserve `NO_PROXY` in observed runtime environment
- [ ] Validate committed prevention script directly on WSL/kind after next IP change
- [ ] Validate application-level HTTP Service accessibility (separate incident)

## Customer-facing English summary

> The deployment was blocked because the Kubernetes worker's container runtime retained an outdated proxy address. We verified the current proxy path to Docker Hub, updated the containerd proxy configuration, and confirmed both application Pods were running and ready. HTTP service accessibility still requires a separate check. A repeatable, operator-controlled synchronization script has been prepared for future network changes.
