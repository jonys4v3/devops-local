resource "docker_network" "this" {
<<<<<<< HEAD
  name   = var.name
  driver = "bridge"

  ipam_config {
    subnet = var.cidr
  }

  dynamic "labels" {
    for_each = var.labels
    content {
      label = labels.key
      value = labels.value
    }
=======
  name   = "${var.project_name}_shared_network"
  driver = "bridge"

  labels {
    label = "project"
    value = var.project_name
  }

  labels {
    label = "managed_by"
    value = "terraform"
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
  }
}
