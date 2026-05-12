variable "enable_backup" {
  description = "Enable scheduled backups"
  type        = bool
  default     = false
}

variable "cluster_name" {
  description = "PostgreSQL cluster name"
  type        = string
}

variable "namespace" {
  description = "Namespace for PostgreSQL cluster"
  type        = string
}

variable "minio_endpoint" {
  type = string
}

variable "minio_bucket" {
  type = string
}

variable "minio_access_key" {
  type      = string
  sensitive = true
}

variable "minio_secret_key" {
  type      = string
  sensitive = true
}

variable "full_backup_schedule" {
  description = "Cron for WAL-G full backup"
  type        = string
  default     = "0 9 * * *"
}

variable "wal_backup_schedule" {
  description = "Cron for WAL archive"
  type        = string
  default     = "*/2 * * * *"
}

variable "backup_retention" {
  type    = string
  default = "7d"
}

