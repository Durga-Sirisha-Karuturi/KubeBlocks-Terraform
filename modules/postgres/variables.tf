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

