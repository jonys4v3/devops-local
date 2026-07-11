#!/usr/bin/env bash
set -uo pipefail

echo "Inicializando Terraform..."
terraform init -upgrade

PROJECT_NAME="$(awk -F= '/^[[:space:]]*project_name[[:space:]]*=/{gsub(/[ "]/, "", $2); print $2}' terraform.tfvars 2>/dev/null | tail -n 1)"

if [ -z "${PROJECT_NAME}" ]; then
  PROJECT_NAME="devops"
fi

echo "Usando PROJECT_NAME=${PROJECT_NAME}"
echo ""

tf_in_state() {
  local address="$1"
  terraform state list 2>/dev/null | grep -Fxq "$address"
}

import_network_if_exists() {
  local name="$1"
  local address="$2"

  if tf_in_state "$address"; then
    echo "[OK] ${name} ya está gestionado por Terraform: ${address}"
    return 0
  fi

  local id
  id="$(docker network inspect "$name" -f '{{.ID}}' 2>/dev/null || true)"

  if [ -n "$id" ]; then
    echo "[INFO] La red Docker '${name}' ya existe. Importando a Terraform..."
    terraform import -input=false "$address" "$id" || true
  else
    echo "[INFO] La red Docker '${name}' no existe. Terraform la creará."
  fi
}

import_volume_if_exists() {
  local name="$1"
  local address="$2"

  if tf_in_state "$address"; then
    echo "[OK] ${name} ya está gestionado por Terraform: ${address}"
    return 0
  fi

  local volume_name
  volume_name="$(docker volume inspect "$name" -f '{{.Name}}' 2>/dev/null || true)"

  if [ -n "$volume_name" ]; then
    echo "[INFO] El volumen Docker '${name}' ya existe. Importando a Terraform..."
    terraform import -input=false "$address" "$volume_name" || true
  else
    echo "[INFO] El volumen Docker '${name}' no existe. Terraform lo creará."
  fi
}

import_container_if_exists() {
  local name="$1"
  local address="$2"

  if tf_in_state "$address"; then
    echo "[OK] ${name} ya está gestionado por Terraform: ${address}"
    return 0
  fi

  local id
  id="$(docker inspect "$name" -f '{{.Id}}' 2>/dev/null || true)"

  if [ -n "$id" ]; then
    echo "[INFO] El contenedor Docker '${name}' ya existe. Importando a Terraform..."
    terraform import -input=false "$address" "$id" || true
  else
    echo "[INFO] El contenedor Docker '${name}' no existe. Terraform lo creará."
  fi
}

echo "Comprobando recursos Docker existentes..."
echo ""

import_network_if_exists \
  "${PROJECT_NAME}_shared_network" \
  "module.network.docker_network.this"

import_volume_if_exists \
  "${PROJECT_NAME}_gitlab_config" \
  "module.gitlab.docker_volume.config"

import_volume_if_exists \
  "${PROJECT_NAME}_gitlab_logs" \
  "module.gitlab.docker_volume.logs"

import_volume_if_exists \
  "${PROJECT_NAME}_gitlab_data" \
  "module.gitlab.docker_volume.data"

import_volume_if_exists \
  "${PROJECT_NAME}_jenkins_home" \
  "module.jenkins.docker_volume.home"

import_volume_if_exists \
  "${PROJECT_NAME}_artifactory_data" \
  "module.artifactory.docker_volume.data"

import_container_if_exists \
  "${PROJECT_NAME}_gitlab" \
  "module.gitlab.docker_container.this"

import_container_if_exists \
  "${PROJECT_NAME}_jenkins" \
  "module.jenkins.docker_container.this"

import_container_if_exists \
  "${PROJECT_NAME}_artifactory" \
  "module.artifactory.docker_container.this"

echo ""
echo "Validando Terraform..."
terraform validate

echo ""
echo "Ejecutando terraform apply..."
terraform apply