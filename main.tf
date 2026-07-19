module "network" {
  source = "./modules/network"

  name   = "${local.name_prefix}-net"
  cidr   = var.network_cidr
  labels = local.common_labels
}

module "gitlab" {
  source = "./modules/gitlab"

  name          = "${local.name_prefix}-gitlab"
  image_name    = local.service_images.gitlab
  build_context = "${path.root}/services/gitlab"
  network_name  = module.network.name
  timezone      = var.timezone

  external_url = var.gitlab_external_url
  http_port    = var.gitlab_http_port
  ssh_port     = var.gitlab_ssh_port

  labels = local.common_labels
}

module "jenkins" {
  source = "./modules/jenkins"

  name          = "${local.name_prefix}-jenkins"
  image_name    = local.service_images.jenkins
  build_context = "${path.root}/services/jenkins"
  network_name  = module.network.name
  timezone      = var.timezone

  http_port      = var.jenkins_http_port
  agent_port     = var.jenkins_agent_port
  admin_user     = var.jenkins_admin_user
  admin_password = var.jenkins_admin_password

  labels = local.common_labels
}

# Sustituye al antiguo module "artifactory".
module "nexus" {
  source = "./modules/nexus"

  name              = "${local.name_prefix}-nexus"
  image             = local.service_images.nexus
  network_name      = module.network.name
  timezone          = var.timezone
  http_port         = var.nexus_http_port
  docker_group_port = var.nexus_docker_group_port
  java_min_mem      = var.nexus_java_min_mem
  java_max_mem      = var.nexus_java_max_mem
  java_direct_mem   = var.nexus_java_direct_mem

  labels = local.common_labels
}
=======
  source       = "./modules/network"
  project_name = var.project_name
}

module "gitlab" {
  source              = "./modules/gitlab"
  project_name        = var.project_name
  timezone            = var.timezone
  network_name        = module.network.network_name
  gitlab_external_url = var.gitlab_external_url
  gitlab_ssh_port     = var.gitlab_ssh_port
}

module "jenkins" {
  source                 = "./modules/jenkins"
  project_name           = var.project_name
  timezone               = var.timezone
  network_name           = module.network.network_name
  jenkins_version        = var.jenkins_version
  jenkins_admin_user     = var.jenkins_admin_user
  jenkins_admin_password = var.jenkins_admin_password
  jenkins_public_url     = var.jenkins_public_url
  jenkins_admin_email    = var.jenkins_admin_email

  depends_on = [module.gitlab]
}

module "artifactory" {
  source                 = "./modules/artifactory"
  project_name           = var.project_name
  timezone               = var.timezone
  network_name           = module.network.network_name
  artifactory_public_url = var.artifactory_public_url

  artifactory_db_name     = var.artifactory_db_name
  artifactory_db_user     = var.artifactory_db_user
  artifactory_db_password = var.artifactory_db_password

  depends_on = [module.jenkins]
}
