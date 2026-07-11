locals {
  csp = "default-src 'self'; img-src 'self' data:; style-src 'self' 'unsafe-inline'; script-src 'self'; object-src 'none'; frame-ancestors 'self'; base-uri 'self';"
}

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
  }
}

resource "docker_container" "this" {
  name     = "${var.project_name}_jenkins"
  hostname = "jenkins"
  image   = docker_image.this.image_id
  restart = "always"
  user    = "root"

  env = [
    "TZ=${var.timezone}",
    "CASC_JENKINS_CONFIG=/var/jenkins_home/casc.yaml",
    "JENKINS_ADMIN_ID=${var.jenkins_admin_user}",
    "JENKINS_ADMIN_PASSWORD=${var.jenkins_admin_password}",
    "JENKINS_PUBLIC_URL=${var.jenkins_public_url}",
    "JENKINS_ADMIN_EMAIL=${var.jenkins_admin_email}",
    "JAVA_OPTS=-Djenkins.install.runSetupWizard=false -Dhudson.model.DirectoryBrowserSupport.CSP=${local.csp}"
  ]

  ports {
    internal = 8080
    external = 8080
    protocol = "tcp"
  }

  ports {
    internal = 50000
    external = 50000
    protocol = "tcp"
  }

  volumes {
    volume_name    = docker_volume.home.name
    container_path = "/var/jenkins_home"
  }

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
  }
}
