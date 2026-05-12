resource "kubernetes_namespace" "pgadmin" {

  count = var.enable_pgadmin ? 1 : 0

  metadata {
    name = "pgadmin"
  }
}

resource "helm_release" "pgadmin" {

  count = var.enable_pgadmin ? 1 : 0

  name       = "pgadmin"
  repository = "https://helm.runix.net"
  chart      = "pgadmin4"

  namespace        = "pgadmin"
  create_namespace = true

  values = [

    yamlencode({

      image = {
        tag = "9.15"
      }

      replicaCount = 1

      env = {
        email    = var.pgadmin_email
        password = var.pgadmin_password
      }

      service = {
        type = var.pgadmin_service_type
      }

      persistence = {
        enabled = true
        size    = var.pgadmin_storage_size
      }

    })

  ]
}

data "kubernetes_service" "pgadmin" {

  count = var.enable_pgadmin ? 1 : 0

  metadata {
    name      = "pgadmin-pgadmin4"
    namespace = "pgadmin"
  }

  depends_on = [
    helm_release.pgadmin
  ]
}
