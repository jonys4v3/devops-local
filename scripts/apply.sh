#!/usr/bin/env bash
set -euo pipefail
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
