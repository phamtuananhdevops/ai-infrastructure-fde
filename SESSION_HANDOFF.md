# Session Handoff

**Last updated:** 2026-11-07

## What has been agreed
- Personalized AI Infrastructure FDE roadmap v2: 36 weeks, 8–10 hours/week.
- Learn through one evolving Enterprise AI Inference Platform.
- Method: Build → Break → Fix → Explain.
- Prioritize Kubernetes and AI inference; validate Linux and Terraform strengths before skipping basics.
- Use GitHub as durable cross-account context.
- The learner requested ongoing progress updates to GitHub.

## Current position
- Lab A — Linux & Networking (90 min, 20 points).
- Environment selected: WSL2 Ubuntu, sudo available.
- Task 01: deploy FastAPI at 127.0.0.1:8000 behind Nginx at port 8080; GET /healthz through proxy must return HTTP 200 and JSON status ok.
- Evaluator asked learner to provide chosen environment-readiness commands and their actual outputs.
- **Learner paused before doing the lab. No evidence received. No points assigned.**

## Next action
When learner says "Tiếp tục Lab A", resume at the WSL2 readiness-check question. Do not give commands or root causes upfront; follow the [Lab A rubric](assessments/lab-a-linux-networking.md).

If learner cannot access a lab machine, offer optional conceptual incident simulations or English customer scenarios, but do not count these as practical Lab A completion.

## Mentor protocol for future sessions
1. Read LEARNING_CONTEXT.md, PROGRESS.md and this handoff before continuing.
2. Ask for or review actual evidence and evaluate it.
3. Update PROGRESS.md and SESSION_HANDOFF.md after a meaningful session, when GitHub write access is available.
4. Commit concise, accurate updates. Never imply background monitoring or autonomous progress tracking.
