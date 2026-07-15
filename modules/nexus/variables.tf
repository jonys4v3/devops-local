variable "name" {
  description = "Nombre del contenedor Nexus."
  type        = string
}

variable "image" {
  description = "Imagen Docker de Nexus Repository 3."
  type        = string
}

variable "network_name" {
  description = "Red Docker compartida de la plataforma."
  type        = string
}

variable "timezone" {
  description = "Zona horaria del contenedor."
  type        = string
}

variable "http_port" {
  description = "Puerto HTTP host para Nexus."
  type        = number
}

variable "docker_group_port" {
  description = "Puerto host reservado para Docker registry group/proxy/hosted en Nexus."
  type        = number
}

variable "java_min_mem" {
  description = "Memoria mínima JVM."
  type        = string
}

variable "java_max_mem" {
  description = "Memoria máxima JVM."
  type        = string
}

variable "java_direct_mem" {
  description = "Memoria directa máxima JVM."
  type        = string
}

variable "labels" {
  description = "Labels comunes."
  type        = map(string)
  default     = {}
}
