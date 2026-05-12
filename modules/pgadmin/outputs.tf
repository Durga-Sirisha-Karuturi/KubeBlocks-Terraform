output "pgadmin_service_name" {
  value = try(
    data.kubernetes_service.pgadmin[0].metadata[0].name,
    "pgadmin disabled"
  )
}

output "pgadmin_cluster_ip" {
  value = try(
    data.kubernetes_service.pgadmin[0].spec[0].cluster_ip,
    "pgadmin disabled"
  )
}

output "pgadmin_nodeport" {
  value = try(
    data.kubernetes_service.pgadmin[0].spec[0].port[0].node_port,
    "No NodePort"
  )
}
