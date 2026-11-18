# WSL2 → kind → containerd proxy recovery

Tools for an isolated Kubernetes lab when WSL's `wsl-proxy` address changes and kind image pulls fail.

See the [incident report](../../labs/w01-linux-networking/incident-01-kind-proxy-imagepullbackoff-2026-11-18.md) for the actual evidence and limitations.

## Usage

```bash
# Refresh env of your *current WSL shell*; `./set-proxy.sh` does not export to its parent.
source scripts/wsl-kind-proxy/set-proxy.sh

# Default read-only validation from the kind worker.
bash scripts/wsl-kind-proxy/sync-kind-containerd-proxy.sh --check

# Optional: write systemd override, but do not restart runtime.
bash scripts/wsl-kind-proxy/sync-kind-containerd-proxy.sh --apply

# Explicitly apply and restart containerd only when lab workload impact is acceptable.
bash scripts/wsl-kind-proxy/sync-kind-containerd-proxy.sh --restart \
  --node k8s-local-worker

kubectl -n fde-warroom get pods -o wide
```

Defaults: `FDE_PROXY_HOST=wsl-proxy`, `FDE_PROXY_PORT=3128`, `KIND_NODE=k8s-local-worker`. To use another kind node, pass `--node <node-name>`. You must rerun synchronization when WSL's resolved proxy address changes.

**Warning:** Intended only for a self-managed kind lab. The sync script changes systemd configuration *inside the named Docker kind node*. `--restart` can interrupt other lab workloads. No changes are made to a live kind node simply by sourcing `set-proxy.sh` or using `--check`. Code has been syntax-checked but not yet exercised against the user's node; review before applying.
