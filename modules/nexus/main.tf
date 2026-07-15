locals {
  install4j_add_vm_params = join(" ", [
    "-Xms${var.java_min_mem}",
    "-Xmx${var.java_max_mem}",
    "-XX:MaxDirectMemorySize=${var.java_direct_mem}",
    "-Djava.util.prefs.userRoot=/nexus-data/javaprefs"
  ])
}

resource "docker_image" "this" {
  name         = var.image
  keep_locally = true
}

resource "docker_volume" "data" {
  name = "${var.name}-data"

  dynamic "labels" {
    for_each = merge(var.labels, { service = "nexus" })
    content {
      label = labels.key
      value = labels.value
    }
  }
}

resource "docker_container" "this" {
  name  = var.name
  image = docker_image.this.image_id

  restart = "unless-stopped"

  env = [
    "TZ=${var.timezone}",
    "INSTALL4J_ADD_VM_PARAMS=${local.install4j_add_vm_params}"
  ]

  ports {
    internal = 8081
    external = var.http_port
    protocol = "tcp"
  }

  # Puerto reservado para repositorios Docker en Nexus.
  # Debes crear/configurar el connector dentro de Nexus en el mismo puerto interno.
  ports {
    internal = var.docker_group_port
    external = var.docker_group_port
    protocol = "tcp"
  }

  volumes {
    volume_name    = docker_volume.data.name
    container_path = "/nexus-data"
    read_only      = false
  }

  networks_advanced {
    name = var.network_name
  }

  healthcheck {
    test         = ["CMD-SHELL", "curl -fsS http://localhost:8081/service/rest/v1/status || exit 1"]
    interval     = "30s"
    timeout      = "10s"
    start_period = "120s"
    retries      = 10
  }

  dynamic "labels" {
    for_each = merge(var.labels, { service = "nexus", replaces = "artifactory" })
    content {
      label = labels.key
      value = labels.value
    }
  }
}
