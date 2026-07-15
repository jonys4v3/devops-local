<<<<<<< HEAD
output "url" { value = "http://localhost:${var.http_port}" }
output "container_name" { value = docker_container.this.name }
output "config_volume" { value = docker_volume.config.name }
output "logs_volume" { value = docker_volume.logs.name }
output "data_volume" { value = docker_volume.data.name }
=======
output "url" {
  value = var.gitlab_external_url
}

output "ssh_url" {
  value = "ssh://localhost:${var.gitlab_ssh_port}"
}

output "container_name" {
  value = docker_container.this.name
}
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
