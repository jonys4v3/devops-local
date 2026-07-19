#!/usr/bin/env bash
set -euo pipefail
NEXUS_URL="$1"
CONTAINER="$2"
ADMIN_PASSWORD="$3"
EXTRA_USER="$4"
EXTRA_EMAIL="$5"
EXTRA_PASSWORD="$6"

echo "Waiting for Nexus API at ${NEXUS_URL}..."
for i in $(seq 1 120); do
  if curl -fsS "${NEXUS_URL}/service/rest/v1/status" >/dev/null 2>&1; then
    break
  fi
  sleep 5
  if [[ "$i" == "120" ]]; then
    echo "Nexus was not ready in time" >&2
    exit 1
  fi
done

INITIAL_PASSWORD=""
if docker exec "${CONTAINER}" test -f /nexus-data/admin.password >/dev/null 2>&1; then
  INITIAL_PASSWORD="$(docker exec "${CONTAINER}" cat /nexus-data/admin.password | tr -d '
')"
fi

if [[ -n "${INITIAL_PASSWORD}" ]]; then
  echo "Changing Nexus admin password..."
  curl -fsS -u "admin:${INITIAL_PASSWORD}" -X PUT     -H 'Content-Type: text/plain'     --data "${ADMIN_PASSWORD}"     "${NEXUS_URL}/service/rest/v1/security/users/admin/change-password" >/dev/null || true
fi

echo "Ensuring Nexus extra admin user ${EXTRA_USER}..."
USER_JSON="{"userId":"${EXTRA_USER}","firstName":"${EXTRA_USER}","lastName":"Admin","emailAddress":"${EXTRA_EMAIL}","password":"${EXTRA_PASSWORD}","status":"active","roles":["nx-admin"]}"

HTTP_CODE=$(curl -s -o /tmp/nexus-user-response.txt -w "%{http_code}" -u "admin:${ADMIN_PASSWORD}"   -H 'Content-Type: application/json'   -X POST   --data "${USER_JSON}"   "${NEXUS_URL}/service/rest/v1/security/users" || true)

if [[ "${HTTP_CODE}" == "204" || "${HTTP_CODE}" == "200" ]]; then
  echo "Nexus admin user created: ${EXTRA_USER}"
elif [[ "${HTTP_CODE}" == "400" || "${HTTP_CODE}" == "409" ]]; then
  echo "Nexus user may already exist. Updating password and roles..."
  curl -fsS -u "admin:${ADMIN_PASSWORD}" -X PUT     -H 'Content-Type: application/json'     --data "${USER_JSON}"     "${NEXUS_URL}/service/rest/v1/security/users/${EXTRA_USER}" >/dev/null || true
  curl -fsS -u "admin:${ADMIN_PASSWORD}" -X PUT     -H 'Content-Type: text/plain'     --data "${EXTRA_PASSWORD}"     "${NEXUS_URL}/service/rest/v1/security/users/${EXTRA_USER}/change-password" >/dev/null || true
else
  echo "Unexpected Nexus response ${HTTP_CODE}:"
  cat /tmp/nexus-user-response.txt || true
  exit 1
fi
