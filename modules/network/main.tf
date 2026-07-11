resource "docker_network" "this" {
  name   = "${var.project_name}_shared_network"
  driver = "bridge"

  labels {
    label = "project"
    value = var.project_name
  }

  labels {
    label = "managed_by"
    value = "terraform"
  }
}
