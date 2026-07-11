output "url" {
  value = var.jenkins_public_url
}

output "container_name" {
  value = docker_container.this.name
}
