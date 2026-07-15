resource "docker_volume" "data" {
  name = "${var.project_name}_artifactory_data"
}

resource "docker_volume" "postgres_data" {
  name = "${var.project_name}_artifactory_postgres_data"
}

resource "docker_image" "postgres" {
  name         = "postgres:16-alpine"
  keep_locally = true
}

resource "docker_container" "postgres" {
  name     = "${var.project_name}_artifactory_postgres"
  hostname = "artifactory-postgres"
  image    = docker_image.postgres.image_id
  restart  = "always"

  env = [
    "TZ=${var.timezone}",
    "POSTGRES_DB=${var.artifactory_db_name}",
    "POSTGRES_USER=${var.artifactory_db_user}",
    "POSTGRES_PASSWORD=${var.artifactory_db_password}"
  ]

  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }

  networks_advanced {
    name    = var.network_name
    aliases = ["artifactory-postgres", "${var.project_name}_artifactory_postgres"]
  }
}

resource "docker_image" "this" {
  name         = "releases-docker.jfrog.io/jfrog/artifactory-oss:7.146.25"
  keep_locally = true

  build {
    context = abspath("${path.root}/services/artifactory")
  }

  triggers = {
    dockerfile_sha = filesha256("${path.root}/services/artifactory/Dockerfile")
    system_sha     = filesha256("${path.root}/services/artifactory/config/system.yaml")
  }
}

resource "docker_container" "this" {
  name     = "${var.project_name}_artifactory"
  hostname = "artifactory"
  image    = docker_image.this.image_id
  restart  = "always"

  env = [
    "TZ=${var.timezone}"
  ]

  ports {
    internal = 8081
    external = 8081
    protocol = "tcp"
  }

  ports {
    internal = 8082
    external = 8082
    protocol = "tcp"
  }

  volumes {
    volume_name    = docker_volume.data.name
    container_path = "/var/opt/jfrog/artifactory"
  }

  volumes {
    host_path      = abspath("${path.root}/services/artifactory/config")
    container_path = "/opt/jfrog/artifactory/var/etc"
    read_only      = false
  }

  networks_advanced {
    name    = var.network_name
    aliases = ["artifactory", "${var.project_name}_artifactory"]
  }

  depends_on = [
    docker_container.postgres
  ]
}