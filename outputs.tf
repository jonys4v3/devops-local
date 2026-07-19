output "network_name" {
  description = "Red Docker de la plataforma."
  value       = module.network.name
}

output "gitlab_url" {
  description = "URL de GitLab."
  value       = module.gitlab.url
}

output "jenkins_url" {
  description = "URL de Jenkins."
  value       = module.jenkins.url
}

output "nexus_url" {
  description = "URL de Nexus Repository."
  value       = module.nexus.url
}

output "nexus_initial_admin_password_command" {
  description = "Comando para leer password inicial admin de Nexus."
  value       = module.nexus.initial_admin_password_command
}

output "volumes" {
  description = "Volúmenes persistentes de la plataforma."
  value = {
    gitlab_config = module.gitlab.config_volume
    gitlab_logs   = module.gitlab.logs_volume
    gitlab_data   = module.gitlab.data_volume
    jenkins_home  = module.jenkins.home_volume
    nexus_data    = module.nexus.data_volume
  }
=======
output "gitlab_url" {
  description = "URL de GitLab"
  value       = module.gitlab.url
}

output "gitlab_ssh" {
  description = "Puerto SSH GitLab"
  value       = module.gitlab.ssh_url
}

output "jenkins_url" {
  description = "URL de Jenkins"
  value       = module.jenkins.url
}

output "jenkins_admin_user" {
  description = "Usuario admin inicial Jenkins"
  value       = var.jenkins_admin_user
}

output "artifactory_url" {
  description = "URL de Artifactory"
  value       = module.artifactory.url
}

output "network_name" {
  description = "Red Docker compartida"
  value       = module.network.network_name
}
