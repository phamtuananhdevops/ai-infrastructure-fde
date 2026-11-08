# Linux OOM Killer — Concept and Active Recall

First discussed: 2026-11-08.
Learning status: Concept discussion only. Not yet verified by a hands-on experiment.

## Core mental model
Memory pressure → kernel attempts reclamation and other mitigation → if allocation cannot be satisfied, an Out-of-Memory (OOM) condition can trigger killing an eligible process.

- OOM Killer is **not** an application bug detector. The memory-hungry application is not necessarily the process selected.
- A process's OOM risk depends in part on memory usage and its badness score; `oom_score_adj` adjusts its priority.
- Differentiate **system-wide OOM** from **memory-cgroup OOM**; a container hitting a memory limit can be killed without the whole host being out of memory.
- Changing `oom_score_adj` changes victim preference; it does **not** add RAM, prevent leaks, or fix capacity issues.

## Recall first (no notes allowed until an attempt)
1. Two apps share a Linux host. App A consumes far more RAM. Does Linux *always* kill App A? Why?
2. What is the role of `oom_score_adj`, and why isn't tuning it a complete fix?
3. How could a container be OOMKilled while the host still has available memory?
4. If FirstSpirit is OOM-killed, what evidence would you collect before making changes?

## Practical verification (later; not yet completed)
- Collect controlled lab evidence from `/proc/<pid>/oom_score` and `/proc/<pid>/oom_score_adj`.
- In a disposable local lab, simulate a safe memory-cgroup limit and inspect relevant cgroup stats, container termination reason, and kernel events.
- Never intentionally exhaust RAM or modify OOM priorities on production services.

## Review schedule
- 2026-11-09: 3-minute independent recall.
- 2026-11-11: Explain a FirstSpirit/Python competition-for-RAM scenario.
- 2026-11-15: Compare host OOM with cgroup/container OOM.
- 2026-12-08: Evidence-based simulated troubleshooting.

**These are target review dates, not scheduled reminders.** The mentor should ask questions before giving answers and document which items the learner can explain without hints.

## Exit criteria
Learner can explain victim selection accurately, distinguish host versus cgroup OOM, identify safe evidence to inspect, and propose mitigation for memory pressure without relying only on restarts.
