resource "kubernetes_namespace" "kb_system" {
  metadata {
    name = "kb-system"
  }
}

resource "kubernetes_namespace" "postgres" {
  metadata {
    name = "postgres"
  }
}

resource "helm_release" "snapshot_controller" {

  name       = "snapshot-controller"
  repository = "https://piraeus.io/helm-charts/"
  chart      = "snapshot-controller"

  namespace = "kube-system"
}

resource "null_resource" "kubeblocks_crds" {

  provisioner "local-exec" {
    command = "kubectl create -f https://github.com/apecloud/kubeblocks/releases/download/v1.0.2/kubeblocks_crds.yaml  || true"
  }
}

resource "helm_release" "kubeblocks" {

  name             = "kubeblocks"
  repository       = "https://apecloud.github.io/helm-charts"
  chart            = "kubeblocks"

  namespace        = "kb-system"
  create_namespace = true

  version = "1.0.2"
  
  values = [
    yamlencode({

      image = {
        registry = "docker.io"
        repository = "apecloud/kubeblocks"
      }

      addonChartImage = {
        registry = "docker.io"
      }

    })
  ]

  depends_on = [
    helm_release.snapshot_controller,
    null_resource.kubeblocks_crds
  ]
}
