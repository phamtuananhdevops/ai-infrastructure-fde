#!/usr/bin/env bash
# Safely synchronize the *running* kind node's containerd proxy after a WSL IP change.
set -euo pipefail

NODE="${KIND_NODE:-k8s-local-worker}"
HOST="${FDE_PROXY_HOST:-wsl-proxy}"
PORT="${FDE_PROXY_PORT:-3128}"
MODE=check
OVERRIDE=/etc/systemd/system/containerd.service.d/99-fde-proxy.conf

usage() {
  cat <<'HELP'
Usage: sync-kind-containerd-proxy.sh [--node KIND_NODE] [--check | --apply | --restart]
  --check    Read-only connectivity/configuration checks (default)
  --apply    Write a systemd drop-in and daemon-reload; no restart
  --restart  Apply then restart containerd (lab workload disruption possible)

Optional env: FDE_PROXY_HOST=wsl-proxy FDE_PROXY_PORT=3128 KIND_NODE=k8s-local-worker
This is for self-managed kind lab nodes, not production or corporate clusters.
HELP
}

while (($#)); do
  case "$1" in
    --node) (($# >= 2)) || { usage >&2; exit 2; }; NODE="$2"; shift 2 ;;
    --check) MODE=check; shift ;;
    --apply) MODE=apply; shift ;;
    --restart) MODE=restart; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage >&2; exit 2 ;;
  esac
done

[[ "$NODE" =~ ^[A-Za-z0-9][A-Za-z0-9_.-]*$ ]] || { echo "Invalid node name" >&2; exit 2; }
[[ "$PORT" =~ ^[0-9]+$ ]] && ((PORT >= 1 && PORT <= 65535)) || {
  echo "Invalid proxy port" >&2; exit 2;
}
command -v docker >/dev/null || { echo "docker not found" >&2; exit 1; }
command -v getent >/dev/null || { echo "getent not found" >&2; exit 1; }

NODE_KIND_CLUSTER="$(docker inspect --format '{{index .Config.Labels "io.x-k8s.kind.cluster"}}' "$NODE" 2>/dev/null)" || {
  echo "Cannot inspect node $NODE" >&2; exit 1;
}
[[ -n "$NODE_KIND_CLUSTER" && "$NODE_KIND_CLUSTER" != '<no value>' ]] || {
  echo "Refusing: $NODE does not carry a kind cluster label" >&2; exit 1;
}

IP="$(getent ahostsv4 "$HOST" | awk 'NR==1 { print $1 }')"
[[ "$IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] || {
  echo "Cannot resolve a valid IPv4 for $HOST" >&2; exit 1;
}
URL="http://${IP}:${PORT}"
echo "[INFO] kind cluster=$NODE_KIND_CLUSTER node=$NODE proxy=$URL"

# Test from inside the worker; WSL host connectivity alone does not suffice.
echo '[CHECK] Proxy CONNECT + Docker Registry HTTPS from kind worker ...'
status="$(docker exec "$NODE" curl -sS -I --noproxy '' --proxy "$URL" \
  --connect-timeout 5 --max-time 20 -o /dev/null \
  -w '%{http_connect}:%{http_code}' https://registry-1.docker.io/v2/)" || {
    echo '[ERROR] Cannot reach Docker Registry through new proxy from kind worker' >&2; exit 1;
  }
[[ "$status" == '200:401' || "$status" == '200:200' ]] || {
  echo "[ERROR] Unexpected proxy/registry status: $status (expected 200:401)" >&2; exit 1;
}
echo "[PASS] Proxy CONNECT / registry response = $status"

echo '[INFO] Current running containerd proxy:'
docker exec "$NODE" sh -c \
  'pid=$(pidof containerd); tr "\000" "\n" </proc/$pid/environ | grep -E "^(HTTP_PROXY|HTTPS_PROXY|NO_PROXY)=" || true'

if [[ "$MODE" == check ]]; then
  echo '[INFO] Read-only check complete. Use --apply or --restart explicitly.'
  exit 0
fi

# Only touch the containerd service in this isolated kind node.
# The kind node's existing NO_PROXY is preserved by not overriding it.
if [[ "$MODE" == restart ]]; then
  echo '[WARNING] Restarting containerd can interrupt image pulls and lab workloads.'
fi

# A single-quoted heredoc would lose shell substitution; use printf via stdin.
docker exec "$NODE" mkdir -p /etc/systemd/system/containerd.service.d
printf '[Service]\nEnvironment="HTTP_PROXY=%s"\nEnvironment="HTTPS_PROXY=%s"\nEnvironment="http_proxy=%s"\nEnvironment="https_proxy=%s"\n' \
  "$URL" "$URL" "$URL" "$URL" | docker exec -i "$NODE" sh -c "cat > '$OVERRIDE'"
docker exec "$NODE" systemctl daemon-reload

echo '[INFO] systemd unit environment after daemon-reload:'
docker exec "$NODE" systemctl show containerd -p Environment

if [[ "$MODE" == apply ]]; then
  echo '[INFO] Drop-in written, but running containerd remains unchanged until restart.'
  exit 0
fi

OLD_NO_PROXY="$(docker exec "$NODE" sh -c 'pid=$(pidof containerd); tr "\000" "\n" </proc/$pid/environ | grep "^NO_PROXY=" || true')"
docker exec "$NODE" systemctl restart containerd
NEW_ENV="$(docker exec "$NODE" sh -c 'pid=$(pidof containerd); tr "\000" "\n" </proc/$pid/environ')"
echo "$NEW_ENV" | grep -Fx "HTTP_PROXY=$URL" >/dev/null || { echo '[ERROR] HTTP_PROXY still not updated' >&2; exit 1; }
echo "$NEW_ENV" | grep -Fx "HTTPS_PROXY=$URL" >/dev/null || { echo '[ERROR] HTTPS_PROXY still not updated' >&2; exit 1; }
NEW_NO_PROXY="$(printf '%s\n' "$NEW_ENV" | grep '^NO_PROXY=' || true)"
[[ "$OLD_NO_PROXY" == "$NEW_NO_PROXY" ]] || {
  echo '[ERROR] NO_PROXY changed during restart; inspect node network configuration' >&2; exit 1;
}
echo '[PASS] Running containerd uses the current proxy and NO_PROXY was preserved.'
echo '[NEXT] kubectl -n fde-warroom get pods -o wide'
