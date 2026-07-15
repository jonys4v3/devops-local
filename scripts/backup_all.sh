#!/usr/bin/env bash
set -euo pipefail
<<<<<<< HEAD

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
=======
BACKUP_FILE="devops_volumes_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
docker run --rm   -v devops_gitlab_config:/backup_src/gitlab_config:ro   -v devops_gitlab_logs:/backup_src/gitlab_logs:ro   -v devops_gitlab_data:/backup_src/gitlab_data:ro   -v devops_jenkins_home:/backup_src/jenkins_home:ro   -v devops_artifactory_data:/backup_src/artifactory_data:ro   -v "$PWD":/backup   alpine   tar czf "/backup/${BACKUP_FILE}" /backup_src
echo "Backup creado: ${BACKUP_FILE}"
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
