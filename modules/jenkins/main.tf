<<<<<<< HEAD
resource "random_password" "admin" {
  count            = var.admin_password == null ? 1 : 0
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

locals {
  effective_admin_password = var.admin_password == null ? random_password.admin[0].result : var.admin_password
}

resource "docker_image" "this" {
  name = var.image_name

  build {
    context = var.build_context
  }

  keep_locally = true
}

resource "docker_volume" "home" {
  name = "${var.name}-home"
}

resource "docker_container" "this" {
  name  = var.name
  image = docker_image.this.image_id

  restart = "unless-stopped"

  env = [
    "TZ=${var.timezone}",
    "JENKINS_ADMIN_ID=${var.admin_user}",
    "JENKINS_ADMIN_PASSWORD=${local.effective_admin_password}",
=======
resource "docker_volume" "home" {
  name = "${var.project_name}_jenkins_home"
}

resource "docker_image" "this" {
  name         = "${var.project_name}/jenkins-secure:${var.jenkins_version}-jdk21"
  keep_locally = true

  build {
    context = abspath("${path.root}/services/jenkins")
  }

  triggers = {
    dockerfile_sha = filesha256("${path.root}/services/jenkins/Dockerfile")
    plugins_sha    = filesha256("${path.root}/services/jenkins/config/plugins.txt")
    casc_sha       = filesha256("${path.root}/services/jenkins/config/casc.yaml")
    csp_sha        = filesha256("${path.root}/services/jenkins/config/init.groovy.d/01-csp.groovy")
  }
}

resource "docker_container" "this" {
  name     = "${var.project_name}_jenkins"
  hostname = "jenkins"
  image    = docker_image.this.image_id
  restart  = "always"
  user     = "root"

  env = [
    "TZ=${var.timezone}",
    "CASC_JENKINS_CONFIG=/var/jenkins_home/casc.yaml",
    "JENKINS_ADMIN_ID=${var.jenkins_admin_user}",
    "JENKINS_ADMIN_PASSWORD=${var.jenkins_admin_password}",
    "JENKINS_PUBLIC_URL=${var.jenkins_public_url}",
    "JENKINS_ADMIN_EMAIL=${var.jenkins_admin_email}",
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
    "JAVA_OPTS=-Djenkins.install.runSetupWizard=false"
  ]

  ports {
    internal = 8080
<<<<<<< HEAD
    external = var.http_port
=======
    external = 8080
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
    protocol = "tcp"
  }

  ports {
    internal = 50000
<<<<<<< HEAD
    external = var.agent_port
=======
    external = 50000
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
    protocol = "tcp"
  }

  volumes {
    volume_name    = docker_volume.home.name
    container_path = "/var/jenkins_home"
  }

<<<<<<< HEAD
  networks_advanced {
    name = var.network_name
  }

  dynamic "labels" {
    for_each = merge(var.labels, { service = "jenkins" })
    content {
      label = labels.key
      value = labels.value
    }
=======
  volumes {
    host_path      = abspath("${path.root}/services/jenkins/config/casc.yaml")
    container_path = "/var/jenkins_home/casc.yaml"
    read_only      = true
  }

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }

  networks_advanced {
    name    = var.network_name
    aliases = ["jenkins", "${var.project_name}_jenkins"]
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
  }
}
