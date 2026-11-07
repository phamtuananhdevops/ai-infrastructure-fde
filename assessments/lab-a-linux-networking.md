# Lab A — Linux & Networking (90 minutes / 20 points)

**Role:** System Engineer. **Evaluator:** Senior Infrastructure Engineer. **Environment:** WSL2 Ubuntu with sudo.

## Ticket INFRA-001 — Task 01 (25 min, 5 points)

Deploy a FastAPI backend listening on `127.0.0.1:8000` behind Nginx on port `8080`.

**Acceptance criteria:**
- `GET http://localhost:8080/healthz` returns HTTP 200 and `{"status":"ok"}`.
- Nginx configuration validates.
- Evidence proves request traverses Nginx, not only direct backend access.
- Learner explains request flow and verification.

**Evidence rubric:** E1 backend listening and responding (1); E2 valid Nginx reverse proxy config (1); E3 proxied HTTP status/body (1); E4 Nginx request-flow evidence (1); E5 explanation (1).

**Initial question:** What commands and outputs would you use to confirm WSL2 Ubuntu is ready before deploying?

## Task 02 — Incident investigation (35 min, 9 points)

- INC-001: client receives HTTP 502.
- INC-002: backend cannot start due to a socket-binding-related error.
- INC-003: a simulated internal hostname cannot be resolved.

Investigate each with logs and commands; do not assume a root cause from symptoms. The evaluator may provide simulated incident data if needed.

## Task 03 — Recovery (15 min, 3 points)

Demonstrate healthy service, valid configuration and no relevant resource conflict.

## Task 04 — Incident report (15 min, 3 points)

Write in English: Impact, Symptoms, Investigation, Root Cause, Resolution, Prevention.

## Rules

No solution or root-cause disclosure before learner investigation. Evaluate each submission as PASS, NEEDS EVIDENCE or FAIL. Work only on disposable lab environments. Do not disable TLS verification or firewall as a permanent fix.

## Current status

**PAUSED — NOT STARTED.** No score and no evidence. Resume at Task 01 readiness question.
