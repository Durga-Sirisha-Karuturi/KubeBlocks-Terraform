variable "cluster_name" {
  description = "PostgreSQL cluster name"
  type        = string
}

variable "namespace" {
  description = "Namespace for PostgreSQL cluster"
  type        = string
}

variable "service_version" {
  description = "PostgreSQL service version"
  type        = string
}

variable "disable_exporter" {
  description = "Disable PostgreSQL exporter"
  type        = bool
}

variable "replicas" {
  description = "Number of PostgreSQL replicas"
  type        = number
}

variable "pg_username" {
  description = "PostgreSQL admin username"
  type        = string
}

variable "pg_password" {
  description = "PostgreSQL admin password"
  type        = string
  sensitive   = true
}

variable "cpu_request" {
  description = "CPU request"
  type        = string
}

variable "cpu_limit" {
  description = "CPU limit"
  type        = string
}

variable "memory_request" {
  description = "Memory request"
  type        = string
}

variable "memory_limit" {
  description = "Memory limit"
  type        = string
}

variable "storage_class" {
  description = "StorageClass name"
  type        = string
}

variable "storage_size" {
  description = "Persistent volume size"
  type        = string
}

variable "enable_loadbalancer" {
  description = "Enable LoadBalancer"
  type        = bool
}

variable "service_type" {
  description = "Kubernetes service type"
  type        = string
}

variable "enable_backup" {
  description = "Enable scheduled backups"
  type        = bool
  default     = false
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

variable "enable_pgvector" {
  description = "Enable pgvector extension"
  type        = bool
  default     = false
}

variable "enable_pgadmin" {
  description = "Enable pgAdmin deployment"
  type        = bool
  default     = false
}

variable "pgadmin_email" {
  type    = string
  default = "admin@gmail.com"
}

variable "pgadmin_password" {
  type      = string
  default = "admin123"
  sensitive = true
}

variable "pgadmin_storage_size" {
  default = "1Gi"
}

variable "pgadmin_service_type" {
  default = "NodePort"
}

