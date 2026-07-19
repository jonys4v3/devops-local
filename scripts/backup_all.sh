#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="${1:-backups/$(date +%Y%m%d-%H%M%S)}"
mkdir -p "${BACKUP_DIR}"

containers=(
  "devops-platform-dev-gitlab"
  "devops-platform-dev-jenkins"
  "devops-platform-dev-nexus"
)

for container in "${containers[@]}"; do
  if docker ps -a --format '{{.Names}}' | grep -qx "${container}"; then
    echo "Backing up volumes from ${container}"
    docker run --rm \
      --volumes-from "${container}" \
      -v "$(pwd)/${BACKUP_DIR}:/backup" \
      alpine \
      tar czf "/backup/${container}.tar.gz" /var/opt/gitlab /etc/gitlab /var/log/gitlab /var/jenkins_home /nexus-data 2>/dev/null || true
  else
    echo "Skipping ${container}; container not found"
  fi
done

echo "Backups stored in ${BACKUP_DIR}"
