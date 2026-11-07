# AI Infrastructure FDE Lab

Personalized **36-week hands-on learning path** for transitioning from enterprise System Engineering / Application Operations to **AI Infrastructure / Forward Deployed Infrastructure Engineering**.

> **Current status:** Roadmap v2 agreed. **Lab A paused, not started, no score.** Later-week labs are planned, not implemented.

## Start here

1. [Personalized 36-week roadmap (v2)](ROADMAP.md)
2. [Entry assessment and rubric](assessments/ENTRY-ASSESSMENT.md)
3. [Udemy Business practical courses](COURSES.md)
4. [Technical English integrated practice](TECHNICAL_ENGLISH.md)
5. [Lab A — Linux & Networking](assessments/lab-a-linux-networking.md)
6. [Week 1 starter lab](labs/w01-linux-networking/README.md)
7. [Target architecture](docs/ARCHITECTURE.md)

The [original roadmap (v1)](docs/roadmap-v1.md) is archived for comparison.

## Learning approach

**Build → Break → Fix → Explain.** Build one evolving **Enterprise AI Inference Platform** instead of disconnected tutorial projects. Focus on Kubernetes, inference, GPU operations and customer-facing delivery. Use 8–10 hours per week, mostly hands-on, with WSL2 and local tools before any time-boxed GPU rental.

## Project milestones

| Week | Evidence target |
|---:|---|
| 4 | CPU model serving + inference gateway |
| 12 | Local Kubernetes inference platform |
| 16 | Automated GitOps platform with observability |
| 24 | Real GPU validation and benchmark |
| 32 | Enterprise deployment kit and handover |
| 36 | Portfolio and interviews |

## Starter application

See [FastAPI demo](apps/demo-api/main.py), [Dockerfile](apps/demo-api/Dockerfile), [Nginx sample](labs/w01-linux-networking/nginx.conf) and [CI starter](.github/workflows/starter-checks.yml). These starter artifacts are not proof of a complete production platform.

## Evidence and security

Document commands, actual results, troubleshooting, cleanup and cost. Never commit credentials, customer data or production configuration.
