variable "name" {
  description = "Nombre de la red Docker."
  type        = string
}

variable "cidr" {
  description = "CIDR de la red Docker."
  type        = string
}

variable "labels" {
  description = "Labels comunes."
  type        = map(string)
  default     = {}
}
