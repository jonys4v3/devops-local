output "url" { value = "http://localhost:${var.http_port}" }
output "container_name" { value = docker_container.this.name }
output "config_volume" { value = docker_volume.config.name }
output "logs_volume" { value = docker_volume.logs.name }
output "data_volume" { value = docker_volume.data.name }
