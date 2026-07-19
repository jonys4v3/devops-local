resource "docker_image" "this" {
  name = var.image_name
  build {
    context = var.build_context
  }
  keep_locally = true
}

resource "docker_volume" "home" { name = "${var.name}-home" }

resource "docker_container" "this" {
  name    = var.name
  image   = docker_image.this.image_id
  restart = "unless-stopped"

  env = [
    "TZ=${var.timezone}",
    "JENKINS_ADMIN_ID=${var.admin_user}",
    "JENKINS_ADMIN_PASSWORD=${var.admin_password}",
    "JENKINS_EXTRA_ADMIN_ID=${var.extra_admin_user}",
    "JENKINS_EXTRA_ADMIN_PASSWORD=${var.extra_admin_password}",
    "JAVA_OPTS=-Djenkins.install.runSetupWizard=false"
  ]

  ports {
    internal = 8080
    external = var.http_port
    protocol = "tcp"
  }
  ports {
    internal = 50000
    external = var.agent_port
    protocol = "tcp"
  }

  volumes {
    volume_name    = docker_volume.home.name
    container_path = "/var/jenkins_home"
  }
  networks_advanced {
    name = var.network_name
  }

  dynamic "labels" {
    for_each = merge(var.labels, { service = "jenkins" })
    content {
      label = labels.key
      value = labels.value
    }
  }
}
