# Azure Cloud Track — Practical AI Infrastructure

**Primary cloud: Microsoft Azure (learner preference).** AWS/GCP are conceptual mappings only. No certification preparation.

## Learning goals
Build and operate an enterprise-ready AI inference platform on Azure with low-cost, time-boxed labs. Start locally; use paid Azure resources only with explicit budget and cleanup plans.

| Weeks | Azure topics | Evidence-based lab |
|---|---|---|
| 1–4 | Azure resource groups, Entra ID/RBAC, VNet/subnets, NSG, DNS, budget alerts | Design secure inference network and access model; local CPU deployment |
| 5–8 | AKS concepts, ACR, Azure Load Balancer, ingress, managed identity | Local kind deployment; optional short AKS deployment when account/budget available |
| 9–12 | AKS networking, DNS, node pools, Azure Monitor, Log Analytics | Troubleshoot simulated or real AKS connectivity, rollout and scheduling incidents |
| 13–16 | Terraform azurerm provider, remote state, Key Vault, GitHub Actions, workload identity | Reproducible Azure IaC with plan, apply, validation and destroy |
| 17–20 | Azure GPU VM and AKS GPU node pools, quotas, driver stack, Azure Blob Storage | GPU infrastructure design, quota and VRAM sizing; no rental required yet |
| 21–24 | vLLM serving on Azure GPU, TTFT, throughput, p95, cost per workload | Time-boxed GPU benchmark with actual hardware and spend logged |
| 25–28 | Private Link, private AKS/ACR, Key Vault, Azure Policy, least privilege | Enterprise network/security design and restricted-access deployment |
| 29–32 | Azure Monitor, incident response, backup/recovery, cost optimization | Production runbooks, alerts, rollback and customer handover |
| 33–36 | Azure AI platform architecture and trade-offs | Interview-ready system design, demo and cost narrative |

## Guardrails
- No assumption of an active Azure subscription, available credits, GPU quota or Udemy Business course access.
- Azure Kubernetes Service, Log Analytics, GPU VMs and networking components may incur charges; check pricing and quotas before creating them.
- Set budget alerts (not a hard spending cap), tag resources, record actual costs, and destroy lab infrastructure promptly.
- Do not commit secrets, subscription identifiers or company data.
- Local simulations are labeled as such; never claim production or cloud validation without real evidence.

## Udemy Business catalog search terms
Azure hands-on networking; Azure Kubernetes Service AKS; Terraform Azure; Azure Monitor Log Analytics; Azure Key Vault managed identity; GPU Azure Kubernetes; vLLM on Kubernetes. Confirm availability in the organization's catalog before assigning specific lectures.
