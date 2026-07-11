resource "docker_volume" "config" {
  name = "${var.project_name}_gitlab_config"
}

resource "docker_volume" "logs" {
  name = "${var.project_name}_gitlab_logs"
}

resource "docker_volume" "data" {
  name = "${var.project_name}_gitlab_data"
}

resource "docker_image" "this" {
  name         = "${var.project_name}/gitlab-ce-custom:local"
  keep_locally = true

  build {
    context = abspath("${path.root}/services/gitlab")
  }

  triggers = {
    dockerfile_sha = filesha256("${path.root}/services/gitlab/Dockerfile")
    config_sha     = filesha256("${path.root}/services/gitlab/config/gitlab_omnibus_config.tpl")
  }
}

resource "docker_container" "this" {
  name     = "${var.project_name}_gitlab"
  hostname = "gitlab"
  image   = docker_image.this.image_id
  restart = "always"

  shm_size = 268435456

  env = [
    "TZ=${var.timezone}",
    "GITLAB_OMNIBUS_CONFIG=${templatefile("${path.root}/services/gitlab/config/gitlab_omnibus_config.tpl", {
      gitlab_external_url = var.gitlab_external_url
      gitlab_ssh_port     = var.gitlab_ssh_port
    })}"
  ]

  ports {
    internal = 8929
    external = 8929
    protocol = "tcp"
  }

  ports {
    internal = 22
    external = var.gitlab_ssh_port
    protocol = "tcp"
  }

  volumes {
    volume_name    = docker_volume.config.name
    container_path = "/etc/gitlab"
  }

  volumes {
    volume_name    = docker_volume.logs.name
    container_path = "/var/log/gitlab"
  }

  volumes {
    volume_name    = docker_volume.data.name
    container_path = "/var/opt/gitlab"
  }

  networks_advanced {
    name    = var.network_name
    aliases = ["gitlab", "${var.project_name}_gitlab"]
  }
}
