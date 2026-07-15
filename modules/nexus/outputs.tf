output "url" {
  description = "URL de Nexus."
  value       = "http://localhost:${var.http_port}"
}

output "container_name" {
  description = "Nombre del contenedor Nexus."
  value       = docker_container.this.name
}

output "data_volume" {
  description = "Volumen persistente de Nexus."
  value       = docker_volume.data.name
}

output "initial_admin_password_command" {
  description = "Comando para obtener el password inicial del usuario admin."
  value       = "docker exec ${docker_container.this.name} cat /nexus-data/admin.password"
}
