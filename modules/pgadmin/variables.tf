variable "enable_pgadmin" {
  description = "Enable pgAdmin deployment"
  type        = bool
  default     = false
}

variable "pgadmin_email" {
  default = "admin@gmail.com"
}

variable "pgadmin_password" {
  default = "admin123"
}

variable "pgadmin_storage_size" {
  default = "1Gi"
}

variable "pgadmin_service_type" {
  default = "NodePort"
}

