cluster_name        = "devops-cluster"
namespace           = "postgres"
service_version     = "16.4.0"
disable_exporter    = false
replicas            = 2

pg_username         = "sify"
pg_password         = "sify123"

cpu_request         = "500m"
cpu_limit           = "1"

memory_request      = "512Mi"
memory_limit        = "1Gi"

storage_class       = "longhorn"
storage_size        = "5Gi"

enable_loadbalancer = true
service_type        = "LoadBalancer"

enable_backup        = true

minio_endpoint       = "https://10.0.1.6:31873"

minio_bucket         = "kb-backup"

minio_access_key     = "admin"

minio_secret_key     = "admin12345"

full_backup_schedule = "0 6 * * *"

wal_backup_schedule  = "*/2 * * * *"

backup_retention     = "7d"

enable_pgvector = true

enable_pgadmin      = true

pgadmin_email       = "admin@gmail.com"

pgadmin_password    = "admin123"

pgadmin_storage_size = "1Gi"

pgadmin_service_type = "NodePort"

