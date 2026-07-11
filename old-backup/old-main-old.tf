terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  # Se conecta automáticamente al socket nativo de Docker de tu máquina
}

# =========================================================
# 1. RED COMPARTIDA Y VOLÚMENES PRIVADOS
# =========================================================

resource "docker_network" "devops_network" {
  name   = "devops_shared_network"
  driver = "bridge"
}

resource "docker_volume" "gitlab_config"    { name = "gitlab_config" }
resource "docker_volume" "gitlab_logs"      { name = "gitlab_logs" }
resource "docker_volume" "gitlab_data"      { name = "gitlab_data" }
resource "docker_volume" "jenkins_home"     { name = "jenkins_home" }
resource "docker_volume" "artifactory_data" { name = "artifactory_data" }

# =========================================================
# 2. DESCARGA DE IMÁGENES OFICIALES (ÚLTIMAS VERSIONES)
# =========================================================

resource "docker_image" "gitlab_img" {
  name = "gitlab/gitlab-ce:latest"
}

resource "docker_image" "jenkins_img" {
  name = "jenkins/jenkins:lts-jdk17"
}

resource "docker_image" "artifactory_img" {
  name = "releases-docker.jfrog.io/jfrog/artifactory-oss:latest"
}

# =========================================================
# 3. DESPLIEGUE DE CONTENEDORES
# =========================================================

# ---🦊 GITLAB ---
resource "docker_container" "gitlab" {
  name     = "devops_gitlab"
  image    = docker_image.gitlab_img.image_id
  restart  = "always"
  shm_size = 256

  env = [
    "GITLAB_OMNIBUS_CONFIG=external_url 'http://localhost:8929'\ngitlab_rails['gitlab_shell_ssh_port'] = 2222"
  ]

  ports {
    internal = 8929
    external = 8929
  }
  ports {
    internal = 22
    external = 2222
  }

  volumes {
    volume_name    = docker_volume.gitlab_config.name
    container_path = "/etc/gitlab"
  }
  volumes {
    volume_name    = docker_volume.gitlab_logs.name
    container_path = "/var/log/gitlab"
  }
  volumes {
    volume_name    = docker_volume.gitlab_data.name
    container_path = "/var/opt/gitlab"
  }

  networks_advanced {
    name = docker_network.devops_network.name
  }
}

# ---👴 JENKINS ---
resource "docker_container" "jenkins" {
  name    = "devops_jenkins"
  image   = docker_image.jenkins_img.image_id
  restart = "always"

  ports {
    internal = 8080
    external = 8080
  }
  ports {
    internal = 50000
    external = 50000
  }

  volumes {
    volume_name    = docker_volume.jenkins_home.name
    container_path = "/var/jenkins_home"
  }

  networks_advanced {
    name = docker_network.devops_network.name
  }

  # Asegura el orden de encendido lógico
  depends_on = [docker_container.gitlab]
}

# ---🐸 ARTIFACTORY ---
resource "docker_container" "artifactory" {
  name    = "devops_artifactory"
  image   = docker_image.artifactory_img.image_id
  restart = "always"

  ports {
    internal = 8081
    external = 8081
  }
  ports {
    internal = 8082
    external = 8082
  }

  volumes {
    volume_name    = docker_volume.artifactory_data.name
    container_path = "/var/opt/jfrog/artifactory"
  }

  networks_advanced {
    name = docker_network.devops_network.name
  }

  depends_on = [docker_container.jenkins]
}