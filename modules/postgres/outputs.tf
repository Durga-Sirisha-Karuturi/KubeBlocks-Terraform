output "postgres_primary_service" {
  value = data.kubernetes_service.postgres_primary.metadata[0].name
}

output "postgres_primary_cluster_ip" {
  value = try(
    data.kubernetes_service.postgres_primary.spec[0].cluster_ip,
    "pending"
  )
}

output "postgres_primary_port" {
  value = try(
    data.kubernetes_service.postgres_primary.spec[0].port[0].port,
    "pending"
  )
}

output "postgres_primary_nodeport" {
  value = try(
    data.kubernetes_service.postgres_primary.spec[0].port[0].node_port,
    "not-applicable"
  )
}

output "postgres_primary_lb_ip" {
  value = try(
    data.kubernetes_service.postgres_primary.status[0].load_balancer[0].ingress[0].ip,
    "pending"
  )
}

output "postgres_replica_service" {
  value = data.kubernetes_service.postgres_headless.metadata[0].name
}

output "postgres_replica_cluster_ip" {
  value = try(
    data.kubernetes_service.postgres_headless.spec[0].cluster_ip,
    "headless-service"
  )
}

output "postgres_replica_endpoint" {
  value = "${data.kubernetes_service.postgres_headless.metadata[0].name}.${var.namespace}.svc.cluster.local"
}
