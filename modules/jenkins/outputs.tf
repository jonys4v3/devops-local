output "url" { value = "http://localhost:${var.http_port}" }
output "container_name" { value = docker_container.this.name }
output "home_volume" { value = docker_volume.home.name }
output "admin_user" { value = var.admin_user }
output "admin_password" {
  value     = local.effective_admin_password
  sensitive = true
}
