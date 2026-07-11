module "network" {
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

  depends_on = [module.jenkins]
}
