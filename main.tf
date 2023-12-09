### Karpenter
resource "helm_release" "karpenter" {
  count = var.karpenter != null ? 1 : 0

  name             = var.karpenter.name
  repository       = local.karpenter.repository
  chart            = local.karpenter.chart
  version          = var.karpenter.version
  namespace        = var.karpenter.namespace
  create_namespace = true

  values = var.karpenter.values

  dynamic "set" {
    for_each = var.karpenter.set

    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_list" {
    for_each = var.karpenter.set_list

    content {
      name  = set_list.key
      value = set_list.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.karpenter.set_sensitive

    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }
}


### Cert manager
resource "helm_release" "cert_manager" {
  count = var.cert_manager != null ? 1 : 0

  name             = var.cert_manager.name
  repository       = local.cert_manager.repository
  chart            = local.cert_manager.chart
  version          = var.cert_manager.version
  namespace        = var.cert_manager.namespace
  create_namespace = true

  values = var.cert_manager.values

  dynamic "set" {
    for_each = var.cert_manager.set

    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_list" {
    for_each = var.cert_manager.set_list

    content {
      name  = set_list.key
      value = set_list.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.cert_manager.set_sensitive

    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  depends_on = [helm_release.karpenter]
}


### External DNS
resource "helm_release" "external_dns" {
  count = var.external_dns != null ? 1 : 0

  name             = var.external_dns.name
  repository       = local.external_dns.repository
  chart            = local.external_dns.chart
  version          = var.external_dns.version
  namespace        = var.external_dns.namespace
  create_namespace = true

  values = var.external_dns.values

  dynamic "set" {
    for_each = var.external_dns.set

    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_list" {
    for_each = var.external_dns.set_list

    content {
      name  = set_list.key
      value = set_list.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.external_dns.set_sensitive

    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  depends_on = [helm_release.karpenter]
}


### NGINX Ingress
resource "helm_release" "ingress_nginx" {
  count = var.ingress_nginx != null ? 1 : 0

  name             = var.ingress_nginx.name
  repository       = local.ingress_nginx.repository
  chart            = local.ingress_nginx.chart
  version          = var.ingress_nginx.version
  namespace        = var.ingress_nginx.namespace
  create_namespace = true

  values = var.ingress_nginx.values

  dynamic "set" {
    for_each = var.ingress_nginx.set

    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_list" {
    for_each = var.ingress_nginx.set_list

    content {
      name  = set_list.key
      value = set_list.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.ingress_nginx.set_sensitive

    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  depends_on = [helm_release.karpenter]
}


### Argo CD
resource "helm_release" "argo_cd" {
  count = var.argo_cd != null ? 1 : 0

  name             = var.argo_cd.name
  repository       = local.argo_cd.repository
  chart            = local.argo_cd.chart
  version          = var.argo_cd.version
  namespace        = var.argo_cd.namespace
  create_namespace = true

  values = var.argo_cd.values

  dynamic "set" {
    for_each = var.argo_cd.set

    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_list" {
    for_each = var.argo_cd.set_list

    content {
      name  = set_list.key
      value = set_list.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.argo_cd.set_sensitive

    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  depends_on = [helm_release.cert_manager, helm_release.ingress_nginx]
}
