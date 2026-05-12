terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}
resource "kubectl_manifest" "pgvector_opsdef" {

  count = var.enable_pgvector ? 1 : 0

  yaml_body = templatefile(
    "${path.module}/manifests/opsdef-pgvector.yaml",

    {
      namespace = var.namespace
    }
  )
}

resource "kubectl_manifest" "pgvector_request" {

  count = var.enable_pgvector ? 1 : 0

  yaml_body = templatefile(
    "${path.module}/manifests/pgvector.yaml",

    {
      cluster_name = var.cluster_name
      namespace    = var.namespace
    }
  )

  depends_on = [
    kubectl_manifest.pgvector_opsdef
  ]
}
