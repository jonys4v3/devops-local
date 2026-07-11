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
