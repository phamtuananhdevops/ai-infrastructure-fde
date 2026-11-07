# AI Infrastructure FDE Lab

Hands-on **36-week roadmap (8–10 hours/week)** for a System Engineer / Application Operations professional moving toward **AI Infrastructure / Forward Deployed Infrastructure Engineering**.

> **Status:** Curriculum scaffold and Week 1 starter files. Later-week infrastructure and GPU labs are **planned, not implemented**. Do not mistake roadmap milestones for validated deployments.

## Start here

1. Read [36-week roadmap](ROADMAP.md).
2. Follow [Week 1 Linux Networking Lab](labs/w01-linux-networking/README.md).
3. Inspect the [FastAPI starter](apps/demo-api/main.py) and [Nginx configuration](labs/w01-linux-networking/nginx.conf).
4. Use [deliverable standards](docs/DELIVERABLES.md) and [incident template](runbooks/incident-template.md).
5. See the [target architecture](docs/ARCHITECTURE.md).

## Portfolio milestones

| Week | Project | Goal |
|---:|---|---|
| 16 | Kubernetes Platform Automation | IaC, CI/CD, GitOps, observability |
| 24 | AI Model Serving Platform | CPU baseline, rented GPU vLLM validation, benchmarks |
| 32 | Enterprise AI Deployment Kit | Secure deployment, operations and customer handover |

## Local API starter

```bash
cd apps/demo-api
python3 -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --host 127.0.0.1 --port 8000
curl http://127.0.0.1:8000/healthz
```

## Security and integrity

- Never commit credentials, secrets, customer information or production infrastructure details.
- Record environment, exact commands, actual outputs, troubleshooting and cleanup for every completed lab.
- AI-assisted coding is welcome, but verify commands and understand failure modes.
- No personal NVIDIA GPU required; plan short rented GPU sessions around weeks 22–24.
