output "url" {
  value = var.artifactory_public_url
}

output "container_name" {
  value = docker_container.this.name
}
