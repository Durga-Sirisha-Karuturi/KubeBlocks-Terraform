variable "enable_pgvector" {
  description = "Enable pgvector extension"
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

