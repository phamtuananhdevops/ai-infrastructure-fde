# Target architecture (planned)

```mermaid
flowchart TD
 Client[Customer App] --> Gateway[API Gateway and Auth]
 Gateway --> Serving[vLLM Inference Service]
 Serving --> GPU[GPU Worker]
 Serving --> Metrics[Prometheus Grafana DCGM]
 Automation[Terraform Ansible CI/CD Helm] -. deploys .-> Serving
```

Target design only. GPU platform has not been deployed.
