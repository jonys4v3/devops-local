resource "docker_network" "this" {
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
  }
}
