#!/usr/bin/env bash
# Source this file before Docker/kind commands: source ./set-proxy.sh
# Running it as a child process cannot update the calling shell.
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  echo 'Source this script: source ./set-proxy.sh' >&2
  exit 2
fi

FDE_PROXY_HOST="${FDE_PROXY_HOST:-wsl-proxy}"
FDE_PROXY_PORT="${FDE_PROXY_PORT:-3128}"

if ! [[ "$FDE_PROXY_PORT" =~ ^[0-9]+$ ]] || (( FDE_PROXY_PORT < 1 || FDE_PROXY_PORT > 65535 )); then
  echo "[ERROR] Invalid proxy port: $FDE_PROXY_PORT" >&2
  return 1
fi

FDE_PROXY_IP="$(getent ahostsv4 "$FDE_PROXY_HOST" | awk 'NR==1 { print $1 }')"
if [[ -z "$FDE_PROXY_IP" ]]; then
  echo "[ERROR] Cannot resolve $FDE_PROXY_HOST from WSL" >&2
  return 1
fi

FDE_PROXY_URL="http://${FDE_PROXY_IP}:${FDE_PROXY_PORT}"
export HTTP_PROXY="$FDE_PROXY_URL" HTTPS_PROXY="$FDE_PROXY_URL"
export FTP_PROXY="$FDE_PROXY_URL" ALL_PROXY="$FDE_PROXY_URL"
export http_proxy="$FDE_PROXY_URL" https_proxy="$FDE_PROXY_URL"
export ftp_proxy="$FDE_PROXY_URL" all_proxy="$FDE_PROXY_URL"

# Retain an existing corporate/lab NO_PROXY list; never replace it blindly.
export NO_PROXY="${NO_PROXY:-localhost,127.0.0.1,127.*,172.*,192.168.*,10.*,169.254.169.254}"
export no_proxy="$NO_PROXY"

printf '[INFO] %s resolves to %s\n' "$FDE_PROXY_HOST" "$FDE_PROXY_IP"
printf '[INFO] WSL shell proxy configured: %s\n' "$FDE_PROXY_URL"
printf '[NOTE] Existing kind/containerd processes do NOT inherit this update.\n'
printf '[NOTE] For a lab kind node, run sync-kind-containerd-proxy.sh --check first.\n'
