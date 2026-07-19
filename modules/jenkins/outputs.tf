output "url" { value = "http://localhost:${var.http_port}" }
output "container_name" { value = docker_container.this.name }
output "home_volume" { value = docker_volume.home.name }
