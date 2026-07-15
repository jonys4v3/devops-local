<<<<<<< HEAD
output "name" {
  description = "Nombre de la red Docker."
  value       = docker_network.this.name
}

output "id" {
  description = "ID de la red Docker."
  value       = docker_network.this.id
=======
output "network_name" {
  value = docker_network.this.name
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
}
