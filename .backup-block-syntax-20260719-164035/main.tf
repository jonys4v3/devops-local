resource "docker_image" "this" {
  name = var.image_name
  build {
    context = var.build_context
  }
  keep_locally = true
}

resource "docker_volume" "config" { name = "${var.name}-config" }
resource "docker_volume" "logs" { name = "${var.name}-logs" }
resource "docker_volume" "data" { name = "${var.name}-data" }

resource "docker_container" "this" {
  name     = var.name
  image    = docker_image.this.image_id
  restart  = "unless-stopped"
  hostname = var.name

  env = [
    "TZ=${var.timezone}",
    "GITLAB_EXTERNAL_URL=${var.external_url}",
    "GITLAB_SSH_PORT=${var.ssh_port}",
    "GITLAB_ROOT_PASSWORD=${var.root_password}"
  ]

  ports { internal = 80 external = var.http_port protocol = "tcp" }
  ports { internal = 22 external = var.ssh_port protocol = "tcp" }

  volumes { volume_name = docker_volume.config.name container_path = "/etc/gitlab" }
  volumes { volume_name = docker_volume.logs.name container_path = "/var/log/gitlab" }
  volumes { volume_name = docker_volume.data.name container_path = "/var/opt/gitlab" }

  networks_advanced { name = var.network_name }

  dynamic "labels" {
    for_each = merge(var.labels, { service = "gitlab" })
    content { label = labels.key value = labels.value }
  }
}

resource "null_resource" "extra_admin" {
  depends_on = [docker_container.this]

  triggers = {
    container = docker_container.this.id
    user      = var.extra_admin_user
  }

  provisioner "local-exec" {
    command = "bash ${path.root}/services/gitlab/bootstrap-admin-user.sh ${docker_container.this.name} ${var.extra_admin_user} ${var.extra_admin_email} '${var.extra_admin_password}'"
  }
}
