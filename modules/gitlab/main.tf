<<<<<<< HEAD
resource "docker_image" "this" {
  name = var.image_name

  build {
    context = var.build_context
  }

  keep_locally = true
}

resource "docker_volume" "config" {
  name = "${var.name}-config"
}

resource "docker_volume" "logs" {
  name = "${var.name}-logs"
}

resource "docker_volume" "data" {
  name = "${var.name}-data"
}

resource "docker_container" "this" {
  name  = var.name
  image = docker_image.this.image_id

  restart  = "unless-stopped"
  hostname = var.name

  env = [
    "TZ=${var.timezone}",
    "GITLAB_EXTERNAL_URL=${var.external_url}",
    "GITLAB_SSH_PORT=${var.ssh_port}"
  ]

  ports {
    internal = 80
    external = var.http_port
=======
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
  image    = docker_image.this.image_id
  restart  = "always"

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
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
    protocol = "tcp"
  }

  ports {
    internal = 22
<<<<<<< HEAD
    external = var.ssh_port
=======
    external = var.gitlab_ssh_port
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
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
<<<<<<< HEAD
    name = var.network_name
  }

  dynamic "labels" {
    for_each = merge(var.labels, { service = "gitlab" })
    content {
      label = labels.key
      value = labels.value
    }
=======
    name    = var.network_name
    aliases = ["gitlab", "${var.project_name}_gitlab"]
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
  }
}
