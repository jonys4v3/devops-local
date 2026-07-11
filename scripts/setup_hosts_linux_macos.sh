#!/usr/bin/env bash
set -euo pipefail

HOSTS_LINE="127.0.0.1 jenkins gitlab artifactory"
HOSTS_FILE="/etc/hosts"

if grep -qE "(^|[[:space:]])jenkins([[:space:]]|$)" "$HOSTS_FILE"   && grep -qE "(^|[[:space:]])gitlab([[:space:]]|$)" "$HOSTS_FILE"   && grep -qE "(^|[[:space:]])artifactory([[:space:]]|$)" "$HOSTS_FILE"; then
  echo "Las entradas jenkins/gitlab/artifactory ya existen en ${HOSTS_FILE}."
else
  echo "$HOSTS_LINE" | sudo tee -a "$HOSTS_FILE" >/dev/null
  echo "Entradas añadidas a ${HOSTS_FILE}: ${HOSTS_LINE}"
fi
