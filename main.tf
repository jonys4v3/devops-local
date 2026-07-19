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
  external_url  = var.gitlab_external_url
  http_port     = var.gitlab_http_port
  ssh_port      = var.gitlab_ssh_port
  labels        = local.common_labels
}

module "jenkins" {
  source = "./modules/jenkins"

  name                 = "${local.name_prefix}-jenkins"
  image_name           = local.service_images.jenkins
  build_context        = "${path.root}/services/jenkins"
  network_name         = module.network.name
  timezone             = var.timezone
  http_port            = var.jenkins_http_port
  agent_port           = var.jenkins_agent_port
  admin_user           = "admin"
  admin_password       = var.platform_admin_password
  extra_admin_user     = var.platform_admin_user
  extra_admin_password = var.platform_admin_password
  labels               = local.common_labels
}

module "nexus" {
  source = "./modules/nexus"

  name                 = "${local.name_prefix}-nexus"
  image                = local.service_images.nexus
  network_name         = module.network.name
  timezone             = var.timezone
  http_port            = var.nexus_http_port
  docker_group_port    = var.nexus_docker_group_port
  java_min_mem         = var.nexus_java_min_mem
  java_max_mem         = var.nexus_java_max_mem
  java_direct_mem      = var.nexus_java_direct_mem
  admin_password       = var.platform_admin_password
  extra_admin_user     = var.platform_admin_user
  extra_admin_email    = var.platform_admin_email
  extra_admin_password = var.platform_admin_password
  labels               = local.common_labels
}