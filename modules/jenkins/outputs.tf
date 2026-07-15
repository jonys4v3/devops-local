<<<<<<< HEAD
output "url" { value = "http://localhost:${var.http_port}" }
output "container_name" { value = docker_container.this.name }
output "home_volume" { value = docker_volume.home.name }
output "admin_user" { value = var.admin_user }
output "admin_password" {
  value     = local.effective_admin_password
  sensitive = true
=======
output "url" {
  value = var.jenkins_public_url
}

output "container_name" {
  value = docker_container.this.name
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
}
