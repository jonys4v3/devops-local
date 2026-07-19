locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_labels = merge(
    {
      project     = var.project_name
      environment = var.environment
      managed_by  = "terraform"
      owner       = "devops"
    },
    var.common_labels
  )

  service_images = {
    gitlab  = "${local.name_prefix}-gitlab:local"
    jenkins = "${local.name_prefix}-jenkins:local"
    nexus   = var.nexus_image
=======
  common_labels = {
    project    = var.project_name
    managed_by = "terraform"
  }
}
