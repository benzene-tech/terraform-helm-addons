locals {
  argo_cd = {
    repository = "oci://ghcr.io/argoproj/argo-helm"
    chart      = "argo-cd"
  }

  cert_manager = {
    repository = "https://charts.jetstack.io"
    chart      = "cert-manager"
  }

  external_dns = {
    repository = "https://kubernetes-sigs.github.io/external-dns"
    chart      = "external-dns"
  }

  istio = {
    repository = "https://istio-release.storage.googleapis.com/charts"
    chart = {
      sidecar = "istiod"
      ambient = "ambient"
    }
  }

  karpenter = {
    repository = "oci://public.ecr.aws/karpenter"
    chart      = "karpenter"
  }
}
