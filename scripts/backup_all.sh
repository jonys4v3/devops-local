#!/usr/bin/env bash
set -euo pipefail
BACKUP_DIR="${1:-backups/$(date +%Y%m%d-%H%M%S)}"
mkdir -p "${BACKUP_DIR}"
docker ps --format '{{.Names}}' | grep 'devops-platform-dev-' | while read -r c; do
  docker run --rm --volumes-from "${c}" -v "$(pwd)/${BACKUP_DIR}:/backup" alpine tar czf "/backup/${c}.tar.gz" / 2>/dev/null || true
done
