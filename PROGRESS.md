# Learning Progress

**Last recorded:** 2026-11-12
**Source of truth:** Evidence and explicit learner confirmations. This file is not an automated telemetry feed.

## Overall status
- Preferred cloud: **Microsoft Azure**; Azure hands-on track added, no cloud lab evidence or Azure subscription verified.
- Udemy Business: **integrated as an optional targeted learning resource; no course enrollment or completion verified**.
- Roadmap: **competency-based, quality-first**; original 36-week pacing is reference only, no fixed completion deadline. Typical weekly study budget remains 8–10 hours.
- Current phase: **Entry assessment**, before hands-on curriculum.
- Overall completed weeks: **0 / 36**.
- Entry assessment completed: **0 / 5**.
- Scores: **Not yet assigned**.
- Practical lab: **Resumed — WSL2 environment readiness checks and read-only process investigation in progress.** No app deployment, remediation, or incident lab completed.
- Next task: **Lab A — Task 01**: Investigate actual local Kubernetes OpenSearch restart causes, starting with read-only node status and sandbox events. Continue safe, read-only process / memory investigation and learner-led reasoning. Corporate-managed laptop confirmed; sudo check blocked because user password is unknown. No password, sudoers, Docker privilege, or memory-pressure/OOM changes without IT authorization and an isolated lab.
- Evidence now submitted for OS/kernel/CPU, RAM/swap/disk, non-root user/group identity, `ps` process snapshot and follow-up PID investigation; sudo authentication not successful. Discussed JVM/cgroup/container OOM reasoning and held an informal technical-English speaking practice. Application deployment and incident evidence still pending. No rubric scores assigned.

## Entry assessment
| Section | Max points | Status | Score |
|---|---:|---|---|
| A. Linux & Networking | 20 | In progress — readiness checks only | — |
| B. Terraform & Automation | 20 | Not started | — |
| C. Kubernetes | 25 | Not started | — |
| D. AI Inference | 15 | Not started | — |
| E. Customer Delivery & English | 20 | Not started | — |

## Self-assessment (unverified)
Linux 4/5; Terraform/Automation 3/5; Kubernetes 1/5; GPU/Inference 1/5; Customer Delivery/English 1/5.

## Evidence log
| Date | Task | Evidence | Result | Notes |
|---|---|---|---|---|
| 2026-11-07 | Lab A / Task 01 | None submitted | Not assessed | Learner paused lab |
| 2026-11-09 | WSL2 readiness (pre-Lab A / Task 01) | Learner supplied outputs of `cat /etc/os-release`, `uname -a`, `lscpu`, `lsipc`, `lsmem`. Ubuntu 22.04.5, WSL2 kernel 6.6.87.2, 14 logical CPUs, 8 GB online WSL2 memory. | OS/kernel/CPU identified | `lsipc` describes IPC, not available RAM; no points assigned. |
| 2026-11-09 | Non-root sudo authentication | Learner ran `sudo -v && echo "sudo OK"`, received password prompt and `Sorry, try again`; learner says this sudo-group user has no known password. | Blocked — no verified sudo execution | Do not confuse group membership with passwordless sudo. Avoid repeated guesses or sudoers/password changes without confirming host ownership/policy. |
| 2026-11-09 | WSL2 account/groups inspection | Output of `id` from non-root prompt: uid=1000(pam3hc), gid=1000(pam3hc), groups include 27(sudo) and 999(docker). | Non-root identity confirmed; sudo execution not yet verified | Docker group may confer root-equivalent power via rootful daemon/socket; do not presume least privilege from UID alone. |
| 2026-11-09 | WSL2 memory and disk inspection | `free -h`: 7.8 GiB total, 5.8 GiB used, 124 MiB free, 1.8 GiB buff/cache, 1.6 GiB available, swap 403 MiB / 12 GiB. `df -h`: `/dev/sdd` mounted at `/` with 890 GiB available; `C:` at `/mnt/c` with 107 GiB available; Docker overlays shown. | Evidence accepted, readiness still partial | Swap occupancy does not prove swap activity; snapfuse 100% normal; do not infer host physical free capacity from WSL VHD `df`. Non-root sudo remains to verify. Avoid memory pressure tests until constrained. |

| 2026-11-09 | Process memory snapshot (read-only) | `ps -eo pid,ppid,user,%mem,rss,comm --sort=-rss \| head -15`: java PID 11062 RSS 884080 KiB (~863 MiB), java PID 10238 RSS 562192 KiB (~549 MiB), kube-apiserver PID 3341 RSS 333696 KiB (~326 MiB); also Prometheus/Grafana. | Snapshot collected; no abnormal process established | System appears to run Kubernetes/monitoring processes; Java process identities unknown; no trend or leak evidence. Sensitive workplace information should not be uploaded. |

| 2026-11-11 | Java/OpenSearch process identification (read-only) | Learner ran `ps -p 11062 -o pid,ppid,user,comm` and `ps -p 11062 -o pid,ppid,etime,args`; observed JVM path `/usr/share/opensearch/jdk/bin/java`, parent PID 9328 and process runtime around 25–29 minutes. | Partial process identification; OpenSearch strongly indicated, not independently confirmed from full command line | Command line output truncated. No config changes or sensitive full command lines shared. |
| 2026-11-11 | Linux/JVM/Kubernetes memory reasoning | Learner explained JVM vs. Java application; different heap sizes; `-Xmx` maximum vs. observed RSS; and that cgroup memory limit can trigger container OOM even when host RAM remains. Explored 1 GiB container limit vs. 2 GiB JVM max heap mismatch. | Conceptual discussion completed; not a scored lab | `-Xmx` is heap cap, not process or container total. Actual OpenSearch container limit and `-Xmx` not verified; scenario hypothetical. |
| 2026-11-11 | Informal technical-English speaking practice | Learner practiced short statements about ~863 MiB RSS, local Kubernetes as a hypothesis, Linux kernel cgroup OOM, and Kubernetes `OOMKilled` status. Instructor corrected English grammar and phrasing. | Speaking practice performed; no formal assessment score | Distinguish hypothetical example (1 GiB limit, `-Xmx2g`) from measured local container settings. |

| 2026-11-12 | Local Kubernetes OpenSearch pod inspection | `kubectl get pods -A` showed `opensearch-0` Running/Ready with 61 restarts, several other pods restarting similarly; learner provided `kubectl describe pod opensearch-0 -n default`. StatefulSet pod on `k8s-local-worker`: main container current Running; last termination `Unknown`, exit 255; event `SandboxChanged`; seven transient startup probe connection refusals. OpenSearch limit 1100Mi, request 100Mi; `OPENSEARCH_JAVA_OPTS=-Xms400m -Xmx400m`. | Real pod description obtained; OOMKilled **not confirmed** | Distinguish previous hypothetical 1Gi / -Xmx2g example from actual 1100Mi / 400m. Investigate node/container runtime and synchronized restart timing without changing corporate-managed cluster. No incident root cause or practical grade assigned. |

| 2026-11-12 | Correlate WSL2 boot with OpenSearch container restart | `uptime -s` showed 2026-11-12 19:03:55 local; OpenSearch main container started 19:04:28 (+33 seconds); `SandboxChanged` event, last termination reason `Unknown` exit 255; many pods restarted in same interval. | Strong evidence WSL2 reboot explains latest OpenSearch container recreation; **not proof for all 61 historical restarts** | No OOMKilled evidence for most recent termination. Trigger of WSL2 reboot remains unverified. Other continuously failing pods such as shipping require independent investigation. |

## Updating this file
After each **actual learning session**, update: date, current week/task, evidence links, rubric scores, blockers, next action and any revised learning priorities. Do not fabricate progress or scores. Ask for confirmation when evidence is ambiguous.

**Updates are not autonomous:** a ChatGPT mentor can update this repository during an active conversation when GitHub write access is connected. It cannot guarantee automatic updates from another account or from offline activities without a connected workflow.
