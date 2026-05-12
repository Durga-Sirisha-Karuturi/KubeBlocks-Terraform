terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}

resource "kubernetes_secret" "backup_secret" {

  count = var.enable_backup ? 1 : 0

  metadata {
    name      = "s3-credential-for-backuprepo"
    namespace = "kb-system"
  }

  data = {
    accessKeyId     = var.minio_access_key
    secretAccessKey = var.minio_secret_key
  }

  type = "Opaque"
}

resource "kubectl_manifest" "backuprepo" {

  count = var.enable_backup ? 1 : 0

  yaml_body = templatefile(
    "${path.module}/manifests/backuprepo.yaml",

    {
      minio_bucket   = var.minio_bucket
      minio_endpoint = var.minio_endpoint
    }
  )

  depends_on = [
    kubernetes_secret.backup_secret
  ]
}

resource "null_resource" "wait_for_backuprepo" {

  count = var.enable_backup ? 1 : 0

  provisioner "local-exec" {

    command = <<EOT
kubectl wait \
--for=jsonpath='{.status.phase}'=Ready \
backuprepo/minio-repo1 \
--timeout=300s
EOT

  }

  depends_on = [
    kubectl_manifest.backuprepo
  ]
}

resource "null_resource" "wait_for_cluster_running" {

  count = var.enable_backup ? 1 : 0

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
    kubectl_manifest.backuprepo
  ]
}

resource "kubectl_manifest" "enable_archive" {

  count = var.enable_backup ? 1 : 0

  yaml_body = templatefile(
    "${path.module}/manifests/enable_archive.yaml",

    {
      cluster_name = var.cluster_name
      namespace    = var.namespace
    }
  )

  depends_on = [
    null_resource.wait_for_cluster_running,
    null_resource.wait_for_backuprepo
  ]
}

resource "kubectl_manifest" "backup_schedule" {

  count = var.enable_backup ? 1 : 0

  yaml_body = templatefile(
    "${path.module}/manifests/wal-g-schedule.yaml",

    {
      cluster_name         = var.cluster_name
      namespace            = var.namespace
      full_backup_schedule = var.full_backup_schedule
      wal_backup_schedule  = var.wal_backup_schedule
      backup_retention     = var.backup_retention
    }
  )

  depends_on = [
    kubectl_manifest.enable_archive
  ]
}

data "kubernetes_resource" "backuprepo" {

  count = var.enable_backup ? 1 : 0

  api_version = "dataprotection.kubeblocks.io/v1alpha1"
  kind        = "BackupRepo"

  metadata {
    name = "minio-repo1"
  }

  depends_on = [
    null_resource.wait_for_backuprepo
  ]
}
