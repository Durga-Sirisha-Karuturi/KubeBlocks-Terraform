module "infrastructure" {
  source = "./modules/infrastructure"
}

module "postgres" {
  source = "./modules/postgres"

  cluster_name        = var.cluster_name
  namespace           = var.namespace
  service_version     = var.service_version
  disable_exporter    = var.disable_exporter
  replicas            = var.replicas
  pg_username         = var.pg_username
  pg_password         = var.pg_password
  cpu_request         = var.cpu_request
  cpu_limit           = var.cpu_limit
  memory_request      = var.memory_request
  memory_limit        = var.memory_limit
  storage_class       = var.storage_class
  storage_size        = var.storage_size
  enable_loadbalancer = var.enable_loadbalancer
  service_type        = var.service_type

  depends_on = [
    module.infrastructure
  ]
}

module "backup" {

  source = "./modules/backup"

  enable_backup        = var.enable_backup
  cluster_name         = var.cluster_name
  namespace            = var.namespace

  minio_endpoint       = var.minio_endpoint
  minio_bucket         = var.minio_bucket
  minio_access_key     = var.minio_access_key
  minio_secret_key     = var.minio_secret_key

  full_backup_schedule = var.full_backup_schedule
  wal_backup_schedule  = var.wal_backup_schedule
  backup_retention     = var.backup_retention

  depends_on = [
    module.postgres
  ]
}

module "pgvector" {

  source = "./modules/pgvector"

  enable_pgvector = var.enable_pgvector
  cluster_name    = var.cluster_name
  namespace       = var.namespace

  depends_on = [
    module.postgres
  ]
}

module "pgadmin" {

  source = "./modules/pgadmin"

  enable_pgadmin       = var.enable_pgadmin
  pgadmin_email        = var.pgadmin_email
  pgadmin_password     = var.pgadmin_password
  pgadmin_storage_size = var.pgadmin_storage_size
  pgadmin_service_type = var.pgadmin_service_type

  depends_on = [
    module.postgres
  ]
}
