# Week 1 — Linux Networking (9 hours)

## Day 1 (1h): environment
Use disposable Linux VM or WSL2. Record OS, kernel, Python version.

## Day 2 (2h): diagnostics
Run `ip addr`, `ip route`, `ss -lntp`, `dig example.com`, `curl -v https://example.com` and `journalctl -xe`. Explain results.

## Day 3 (2h): reverse proxy
From `apps/demo-api`:
```bash
python3 -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --host 127.0.0.1 --port 8000
```
Check `curl http://127.0.0.1:8000/healthz`. Install the sample Nginx server block in a test config, validate with `sudo nginx -t`, reload and check `curl http://localhost:8080/healthz`.

## Day 4 (2h): incidents
Reproduce upstream stopped (502), port conflict, DNS NXDOMAIN and invalid local TLS certificate. Record logs and root cause. Never disable TLS verification as a production fix.

## Day 5 (2h): evidence
Publish sanitized commands, actual results, network diagram, runbook and cleanup instructions.

## Acceptance
Direct and proxied health checks succeed, Nginx config validates, three incidents have evidence and remediation.

## Cleanup
Stop API and remove temporary Nginx config.
