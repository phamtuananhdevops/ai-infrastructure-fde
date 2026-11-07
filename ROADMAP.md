> **Learning policy update (2026-11-07): Competency-based, quality-first.** The 36-week schedule below is an optional pacing reference, **not a deadline**. Advancement depends on independently verified skills, production-grade evidence and stage exit assessments. Longer study time is acceptable. Do not claim job readiness solely because weeks have elapsed.

## Stage exit gates

1. Infrastructure foundations: diagnose networking, process and proxy failures with evidence.
2. Azure engineering: build secure networking, identity and infrastructure-as-code with cleanup/cost controls.
3. Kubernetes/AKS: deploy, troubleshoot and recover workloads independently.
4. Platform engineering: repeatable GitOps delivery, rollback, metrics, security and operational runbooks.
5. AI/LLM infrastructure: explain and operate model serving, GPU resource management and performance trade-offs.
6. Production AI platform: demonstrate SLOs, load tests, capacity, incident recovery and cost analysis.
7. Forward deployment: customer discovery, secure environment adaptation, handover and spoken English explanation.
8. Capstone: design, deploy, break/fix, document and defend an end-to-end enterprise AI inference platform.

**Gate rule:** Evidence and reviewer feedback determine progression. Failed or incomplete assessments lead to targeted practice, not automatic promotion.

# AI Infrastructure FDE — Personalized 36-Week Roadmap (v2)

**Goal:** Transition from enterprise System Engineering / Application Operations into AI Infrastructure / Forward Deployed Infrastructure Engineering.

## Starting self-assessment (unverified)

| Domain | Self-rating (1–5) | Learning strategy |
|---|---:|---|
| Linux & Networking | 4 | Validate through entry assessment; skip basics if proven |
| Terraform / Automation | 3 | Refresh through integrated platform labs |
| Kubernetes & Platform | 1 | Intensive hands-on focus in weeks 5–12 |
| GPU & AI Inference | 1 | Start CPU inference immediately; rent GPU later |
| Customer Delivery & English | 1 | Practice weekly from week 1 |

**Weekly budget:** 8–10 hours (about 5h building/debugging, 2h focused reading, 1h documentation, 1h English/interview). **Method:** Build → Break → Fix → Explain.

## Azure-first cloud integration

**Microsoft Azure is the primary cloud**, integrated across all phases (identity/networking → AKS → Terraform → GPU inference → enterprise operations). See [Azure Cloud Track](AZURE_TRACK.md) for week-by-week hands-on outcomes. AWS/GCP are optional conceptual mappings, not parallel learning tracks. Azure access and spend are not yet verified.

## Weekly schedule

| Week | Phase | Hands-on focus | Status |
|---:|---|---|---|
| 1 | Baseline & CPU Inference | Baseline assessment and lab environment | Not started |
| 2 | Baseline & CPU Inference | llama.cpp CPU inference and latency | Not started |
| 3 | Baseline & CPU Inference | FastAPI inference gateway, auth, streaming | Not started |
| 4 | Baseline & CPU Inference | Docker Compose and resource limits | Not started |
| 5 | Kubernetes Intensive | kind cluster, Pods, Deployments, Services | Not started |
| 6 | Kubernetes Intensive | ConfigMap, Secrets, probes, resource requests | Not started |
| 7 | Kubernetes Intensive | CoreDNS, Services, ingress and TLS | Not started |
| 8 | Kubernetes Intensive | PV/PVC, model cache and storage | Not started |
| 9 | Kubernetes Intensive | Helm chart and release lifecycle | Not started |
| 10 | Kubernetes Intensive | RBAC, ServiceAccounts and NetworkPolicy | Not started |
| 11 | Kubernetes Intensive | CrashLoopBackOff, OOM, DNS and rollout incidents | Not started |
| 12 | Kubernetes Intensive | Rebuild and explain local Kubernetes platform | Not started |
| 13 | Platform Automation | Terraform modules, state and drift | Not started |
| 14 | Platform Automation | Ansible idempotency and CI pipeline | Not started |
| 15 | Platform Automation | Argo CD GitOps and reconciliation | Not started |
| 16 | Platform Automation | Prometheus, Grafana, SLI and alerting | Not started |
| 17 | GPU & AI Serving | GPU VRAM sizing, CUDA and compute concepts | Not started |
| 18 | GPU & AI Serving | Kubernetes GPU device plugin and operator concepts | Not started |
| 19 | GPU & AI Serving | Prefill, decode, KV cache and batching | Not started |
| 20 | GPU & AI Serving | vLLM deployment configuration | Not started |
| 21 | GPU & AI Serving | Short rented-GPU deployment and verification | Not started |
| 22 | GPU & AI Serving | TTFT, throughput, p95 and concurrency benchmark | Not started |
| 23 | GPU & AI Serving | Quantization and performance optimization | Not started |
| 24 | GPU & AI Serving | End-to-end inference demo and incident runbook | Not started |
| 25 | Enterprise Forward Deployment | Customer discovery and English questions | Not started |
| 26 | Enterprise Forward Deployment | Reference architecture and trade-offs | Not started |
| 27 | Enterprise Forward Deployment | Environment profiles and deployment packaging | Not started |
| 28 | Enterprise Forward Deployment | Security, private registry, secrets and audit | Not started |
| 29 | Enterprise Forward Deployment | Restricted-network/offline deployment simulation | Not started |
| 30 | Enterprise Forward Deployment | Incident response and customer updates | Not started |
| 31 | Enterprise Forward Deployment | Capacity, cost and GPU sizing | Not started |
| 32 | Enterprise Forward Deployment | Acceptance tests, rollback and handover | Not started |
| 33 | Portfolio & Interviews | Portfolio README, architecture and demo evidence | Not started |
| 34 | Portfolio & Interviews | Technical interviews: K8s, GPU, IaC and debugging | Not started |
| 35 | Portfolio & Interviews | English customer discovery and incident simulation | Not started |
| 36 | Portfolio & Interviews | Targeted CV, applications and feedback | Not started |

## Single evolving portfolio project

**Enterprise AI Inference Platform:** CPU model serving → API gateway → Docker → local Kubernetes → Helm/GitOps/observability → rented-GPU vLLM and benchmarks → enterprise customer deployment package.

- Week 4: CPU inference + gateway, containerized.
- Week 12: Local Kubernetes inference platform, troubleshooting evidence.
- Week 16: Repeatable automated GitOps platform with dashboards.
- Week 24: GPU inference benchmark with recorded hardware, model and costs.
- Week 32: Customer-ready deployment kit with security and operations handover.
- Week 36: Public portfolio, mock interviews and targeted applications.

## Entry assessment and status

**Assessment A (Linux & Networking): PAUSED — NOT STARTED.** WSL2 Ubuntu with sudo is the intended lab environment. No score has been assigned. Resume when a lab machine is available.

See [entry assessment](assessments/ENTRY-ASSESSMENT.md) and [Lab A instructions](assessments/lab-a-linux-networking.md).

## Cost control

- Weeks 1–16: local WSL2/Linux, Docker, kind and open-source tools; avoid paid cloud.
- Weeks 17–20: GPU theory, configuration and sizing without GPU rental.
- Weeks 21–24: rent GPU only for planned, time-boxed validation and benchmarking.
- Weeks 25–36: reuse artifacts and metrics; use simulated customer environments and synthetic data.

## Evidence and honesty

The roadmap describes **planned work, not completed deployments**. Each lab needs reproducible commands, actual outputs, failure investigation, cleanup and cost notes. Never commit tokens, passwords, customer data or production configuration.

## Learning resources

- https://kubernetes.io/docs/tutorials/
- https://kind.sigs.k8s.io/
- https://helm.sh/docs/
- https://argo-cd.readthedocs.io/
- https://docs.vllm.ai/
- https://github.com/ggml-org/llama.cpp
- https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/
