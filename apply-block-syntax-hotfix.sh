#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f main.tf || ! -d modules ]]; then
  echo "ERROR: ejecuta este script desde la raíz del proyecto Terraform, por ejemplo: ~/devops-local" >&2
  exit 1
fi

TS="$(date +%Y%m%d-%H%M%S)"
mkdir -p ".backup-block-syntax-${TS}"
cp -a modules/gitlab/main.tf modules/jenkins/main.tf modules/nexus/main.tf ".backup-block-syntax-${TS}/"

python3 - <<'PY'
from pathlib import Path
files = [
    Path('modules/gitlab/main.tf'),
    Path('modules/jenkins/main.tf'),
    Path('modules/nexus/main.tf'),
]
replacements = {
    'ports { internal = 80 external = var.http_port protocol = "tcp" }': '''ports {
    internal = 80
    external = var.http_port
    protocol = "tcp"
  }''',
    'ports { internal = 22 external = var.ssh_port protocol = "tcp" }': '''ports {
    internal = 22
    external = var.ssh_port
    protocol = "tcp"
  }''',
    'ports { internal = 8080 external = var.http_port protocol = "tcp" }': '''ports {
    internal = 8080
    external = var.http_port
    protocol = "tcp"
  }''',
    'ports { internal = 50000 external = var.agent_port protocol = "tcp" }': '''ports {
    internal = 50000
    external = var.agent_port
    protocol = "tcp"
  }''',
    'ports { internal = 8081 external = var.http_port protocol = "tcp" }': '''ports {
    internal = 8081
    external = var.http_port
    protocol = "tcp"
  }''',
    'ports { internal = var.docker_group_port external = var.docker_group_port protocol = "tcp" }': '''ports {
    internal = var.docker_group_port
    external = var.docker_group_port
    protocol = "tcp"
  }''',
    'volumes { volume_name = docker_volume.config.name container_path = "/etc/gitlab" }': '''volumes {
    volume_name    = docker_volume.config.name
    container_path = "/etc/gitlab"
  }''',
    'volumes { volume_name = docker_volume.logs.name container_path = "/var/log/gitlab" }': '''volumes {
    volume_name    = docker_volume.logs.name
    container_path = "/var/log/gitlab"
  }''',
    'volumes { volume_name = docker_volume.data.name container_path = "/var/opt/gitlab" }': '''volumes {
    volume_name    = docker_volume.data.name
    container_path = "/var/opt/gitlab"
  }''',
    'volumes { volume_name = docker_volume.home.name container_path = "/var/jenkins_home" }': '''volumes {
    volume_name    = docker_volume.home.name
    container_path = "/var/jenkins_home"
  }''',
    'volumes { volume_name = docker_volume.data.name container_path = "/nexus-data" read_only = false }': '''volumes {
    volume_name    = docker_volume.data.name
    container_path = "/nexus-data"
    read_only      = false
  }''',
    'networks_advanced { name = var.network_name }': '''networks_advanced {
    name = var.network_name
  }''',
    'content { label = labels.key value = labels.value }': '''content {
      label = labels.key
      value = labels.value
    }''',
}
for path in files:
    text = path.read_text(encoding='utf-8')
    for old, new in replacements.items():
        text = text.replace(old, new)
    path.write_text(text, encoding='utf-8')
PY

terraform fmt -recursive
terraform init
terraform validate
