output "name" {
  description = "Nombre de la red Docker."
  value       = docker_network.this.name
}

output "id" {
  description = "ID de la red Docker."
  value       = docker_network.this.id
}
