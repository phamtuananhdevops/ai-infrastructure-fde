# Learning Progress

**Last recorded:** 2026-11-09
**Source of truth:** Evidence and explicit learner confirmations. This file is not an automated telemetry feed.

## Overall status
- Preferred cloud: **Microsoft Azure**; Azure hands-on track added, no cloud lab evidence or Azure subscription verified.
- Udemy Business: **integrated as an optional targeted learning resource; no course enrollment or completion verified**.
- Roadmap: **competency-based, quality-first**; original 36-week pacing is reference only, no fixed completion deadline. Typical weekly study budget remains 8–10 hours.
- Current phase: **Entry assessment**, before hands-on curriculum.
- Overall completed weeks: **0 / 36**.
- Entry assessment completed: **0 / 5**.
- Scores: **Not yet assigned**.
- Practical lab: **Resumed — WSL2 environment readiness checks in progress.** No app deployment or incident lab completed.
- Next task: **Lab A — Task 01**: finish readiness checks (available RAM/swap, disk, permissions); then begin proxy/backend deployment when ready.
- Evidence now submitted for OS/kernel/CPU and online WSL2 memory; application deployment and incident evidence are still pending. No rubric scores assigned.

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
| 2026-11-09 | WSL2 readiness (pre-Lab A / Task 01) | Learner supplied outputs of `cat /etc/os-release`, `uname -a`, `lscpu`, `lsipc`, `lsmem`. Ubuntu 22.04.5, WSL2 kernel 6.6.87.2, 14 logical CPUs, 8 GB online WSL2 memory. | Partial readiness evidence; OS/kernel/CPU identified | Need `free -h`, disk and permission check. `lsipc` is IPC, not available-RAM measurement. Root prompt observed but non-root sudo not verified. Do not assign lab points yet. |

## Updating this file
After each **actual learning session**, update: date, current week/task, evidence links, rubric scores, blockers, next action and any revised learning priorities. Do not fabricate progress or scores. Ask for confirmation when evidence is ambiguous.

**Updates are not autonomous:** a ChatGPT mentor can update this repository during an active conversation when GitHub write access is connected. It cannot guarantee automatic updates from another account or from offline activities without a connected workflow.
