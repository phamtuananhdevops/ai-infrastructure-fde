# Udemy Business — Practical Learning Companion

**Objective:** use the learner's existing Udemy Business access to support the [36-week FDE roadmap](ROADMAP.md). **No certification goal.** Select specific lectures only when needed for project work.

**Availability warning:** These are course recommendations, **not verified as available in the learner's organization's Udemy Business catalog**. Search course titles in the Business account; catalog availability and courses can change. Do not purchase courses separately without checking access.

## Candidate courses (verify in Business catalog)

| Priority | Candidate course | Suggested weeks | Use only these areas | Practical output |
|---|---|---|---|---|
| High | [Docker & Kubernetes: The Practical Guide — Academind](https://www.udemy.com/course/docker-kubernetes-the-practical-guide/) | 1–8 | Docker networks, volumes, Compose, Kubernetes workloads and Services; skip basic Docker if already proficient | CPU inference gateway in containers, then local K8s |
| High | [Kubernetes Troubleshooting: Real-World Production Fixes — Jai M](https://www.udemy.com/course/kubernetes-troubleshooting/) | 7–12 | CrashLoopBackOff, DNS, Service endpoints, probes, OOM, PVC, RBAC and incident labs | At least 5 independently investigated incidents with evidence |
| Medium | [Hands-On Kubernetes for DevOps Engineers: With CI/CD](https://www.udemy.com/course/kubernetes-for-deveops-and-developers-from-basics-to-advanced/) | 13–16 | CI/CD, rollouts, GitOps-related lessons if present | Automated release and rollback |
| Specialized | [LLM on OpenShift AI: Deployment Masterclass](https://www.udemy.com/course/llm-on-openshift-ai-deployment-masterclass/) | 17–24 | vLLM/KServe deployment, resource sizing, quantization and inference API | Model-serving deployment and benchmark; verify access to required environment |

The latter two courses should be inspected for content currency, quality and access before being used; replace with a better course from the organization's catalog if necessary.

## Week-to-course integration

| Weeks | Video focus | Mandatory evidence (not video completion) |
|---|---|---|
| 1–4 | Docker networking, Compose, deployment patterns | Running CPU inference and gateway, API smoke test, failure/recovery notes |
| 5–8 | Kubernetes Pods, Services, DNS, ingress, storage | Working kind cluster with inference gateway and documented request path |
| 9–12 | Kubernetes troubleshooting labs | Reproduce, investigate and fix at least 5 distinct incidents; log and runbook |
| 13–16 | CI/CD, Helm, GitOps, observability | Automated deployment, rollback demonstration, metrics and alerting |
| 17–24 | AI serving, vLLM, KServe, GPU sizing | GPU validation and latency/throughput benchmark when GPU available |
| 25–32 | Enterprise deployment and customer delivery | Security checklist, deployment package, incident update, handover |
| 33–36 | Targeted refresh only | Portfolio, architecture explanation and mock interviews |

## Rules

1. **70% lab / 20% targeted learning / 10% runbook and English explanation.**
2. Watch only a lecture relevant to the active ticket or a specific knowledge gap. Do not track course completion as skill completion.
3. Prefer Build → Break → Fix → Explain. The learner should investigate before receiving solutions from the mentor.
4. Keep the existing Lab A assessment **paused, not started, and ungraded** until the learner is ready.
5. When no lab computer is available, optionally watch targeted lectures on mobile; do not mark hands-on tasks done.
6. Track course title, specific section/lecture, why it was used, evidence URL and outcome in PROGRESS.md.
7. Udemy Business course availability is **unverified** until confirmed by the learner in their organization's catalog.

## Alternative searches within Udemy Business

If a named course is unavailable, search the Business catalog for: **Kubernetes troubleshooting**, **Docker Kubernetes hands-on**, **Helm Argo CD GitOps**, **Prometheus Grafana**, **vLLM inference**, **KServe**, **GPU Kubernetes**, **MLOps deployment**. Choose based on hands-on coverage and current tooling rather than certificate alignment.

## Sources

- [Udemy Business: finding courses](https://business-support.udemy.com/hc/en-us/articles/115005522408-Finding-courses)
- [Udemy Business: catalog differences and imports](https://business-support.udemy.com/hc/en-us/articles/115005228607-Importing-courses-from-Udemy-com-to-my-Udemy-Business-account)
