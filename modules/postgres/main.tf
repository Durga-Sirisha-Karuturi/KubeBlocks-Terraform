terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}

resource "kubernetes_secret" "postgres_secret" {

  metadata {
    name      = "custom-pg-secret"
    namespace = var.namespace
  }

  immutable = true

  data = {
    username = var.pg_username
    password = var.pg_password
  }

  type = "Opaque"
}

resource "kubectl_manifest" "postgres_cluster" {

  yaml_body = templatefile(
    "${path.module}/manifests/postgres-cluster.yaml",

    {
      cluster_name        = var.cluster_name
      namespace           = var.namespace
      service_version     = var.service_version
      disable_exporter    = var.disable_exporter
      replicas            = var.replicas
      cpu_request         = var.cpu_request
      cpu_limit           = var.cpu_limit
      memory_request      = var.memory_request
      memory_limit        = var.memory_limit
      storage_class       = var.storage_class
      storage_size        = var.storage_size
      enable_loadbalancer = var.enable_loadbalancer
      service_type        = var.service_type
    }
  )
}

resource "null_resource" "wait_for_cluster_running" {

  provisioner "local-exec" {

    command = <<EOT
kubectl wait \
--for=jsonpath='{.status.phase}'=Running \
cluster/${var.cluster_name} \
-n ${var.namespace} \
--timeout=1800s
EOT

  }

  depends_on = [
    kubectl_manifest.postgres_cluster
  ]
}

data "kubernetes_service" "postgres_primary" {

  metadata {
    name      = var.cluster_name
    namespace = var.namespace
  }

  depends_on = [
    null_resource.wait_for_cluster_running
  ]
}

data "kubernetes_service" "postgres_headless" {

  metadata {
    name      = "${var.cluster_name}-postgresql-headless"
    namespace = var.namespace
  }

  depends_on = [
    null_resource.wait_for_cluster_running
  ]
}
