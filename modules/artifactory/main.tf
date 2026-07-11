resource "docker_volume" "data" {
  name = "${var.project_name}_artifactory_data"
}

resource "docker_image" "this" {
  name         = "${var.project_name}/artifactory-oss-custom:local"
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
  image   = docker_image.this.image_id
  restart = "always"

  env = [
    "TZ=${var.timezone}",
    "JF_ROUTER_ENTRYPOINTS_EXTERNALPORT=8082"
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

  networks_advanced {
    name    = var.network_name
    aliases = ["artifactory", "${var.project_name}_artifactory"]
  }
}
