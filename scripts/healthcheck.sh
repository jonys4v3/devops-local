#!/usr/bin/env bash
set -euo pipefail
curl -fsS http://localhost:8080/-/health || true
curl -fsS http://localhost:8082/login >/dev/null
curl -fsS http://localhost:8081/service/rest/v1/status
printf 'Healthcheck completed
'
