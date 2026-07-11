output "url" {
  value = var.gitlab_external_url
}

output "ssh_url" {
  value = "ssh://localhost:${var.gitlab_ssh_port}"
}

output "container_name" {
  value = docker_container.this.name
}
