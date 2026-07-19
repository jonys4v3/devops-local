output "gitlab_url" {
  value = module.gitlab.url
}

output "jenkins_url" {
  value = module.jenkins.url
}

output "nexus_url" {
  value = module.nexus.url
}

output "default_credentials" {
  description = "Usuarios iniciales configurados. Los passwords están en terraform.tfvars."
  value = {
    gitlab_root_user   = "root"
    gitlab_extra_user  = var.platform_admin_user
    jenkins_admin      = "admin"
    jenkins_extra_user = var.platform_admin_user
    nexus_admin        = "admin"
    nexus_extra_user   = var.platform_admin_user
  }
}

output "volumes" {
  value = {
    gitlab_config = module.gitlab.config_volume
    gitlab_logs   = module.gitlab.logs_volume
    gitlab_data   = module.gitlab.data_volume
    jenkins_home  = module.jenkins.home_volume
    nexus_data    = module.nexus.data_volume
  }
}
