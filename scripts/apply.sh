#!/usr/bin/env bash
set -euo pipefail

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
