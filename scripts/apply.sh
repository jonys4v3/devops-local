#!/usr/bin/env bash
set -euo pipefail
<<<<<<< HEAD

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

if [[ ! -f terraform.tfvars ]]; then
  echo "terraform.tfvars no existe. Copiando desde terraform.tfvars.example"
  cp terraform.tfvars.example terraform.tfvars
fi

terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
=======
cp -n terraform.tfvars.example terraform.tfvars || true
terraform init
terraform fmt -recursive
terraform validate
terraform apply

echo ""
echo "IMPORTANTE: Para abrir con http://jenkins:8080, http://gitlab:8929 y http://artifactory:8082 ejecuta:"
echo "  ./scripts/setup_hosts_linux_macos.sh"
echo "En Windows, ejecuta PowerShell como Administrador y lanza:"
echo "  ./scripts/setup_hosts_windows.ps1"
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
