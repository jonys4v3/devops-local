#!/usr/bin/env bash
set -euo pipefail
BACKUP_FILE="devops_volumes_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
docker run --rm   -v devops_gitlab_config:/backup_src/gitlab_config:ro   -v devops_gitlab_logs:/backup_src/gitlab_logs:ro   -v devops_gitlab_data:/backup_src/gitlab_data:ro   -v devops_jenkins_home:/backup_src/jenkins_home:ro   -v devops_artifactory_data:/backup_src/artifactory_data:ro   -v "$PWD":/backup   alpine   tar czf "/backup/${BACKUP_FILE}" /backup_src
echo "Backup creado: ${BACKUP_FILE}"
