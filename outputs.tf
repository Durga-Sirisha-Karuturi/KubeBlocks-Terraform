output "postgres_primary_service" {
  value = module.postgres.postgres_primary_service
}

output "postgres_primary_cluster_ip" {
  value = module.postgres.postgres_primary_cluster_ip
}

output "postgres_primary_port" {
  value = module.postgres.postgres_primary_port
}

output "postgres_primary_nodeport" {
  value = module.postgres.postgres_primary_nodeport
}

output "postgres_primary_lb_ip" {
  value = module.postgres.postgres_primary_lb_ip
}

output "postgres_replica_service" {
  value = module.postgres.postgres_replica_service
}

output "postgres_replica_cluster_ip" {
  value = module.postgres.postgres_replica_cluster_ip
}

output "postgres_replica_endpoint" {
  value = module.postgres.postgres_replica_endpoint
}
