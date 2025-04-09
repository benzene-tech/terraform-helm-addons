### Karpenter
resource "helm_release" "karpenter" {
  count = var.karpenter != null ? 1 : 0

  name             = var.karpenter.name
  repository       = local.karpenter.repository
  chart            = local.karpenter.chart
  version          = var.karpenter.version
  namespace        = var.karpenter.namespace
  create_namespace = true
  force_update     = var.karpenter.force_update

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
  force_update     = var.cert_manager.force_update

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
  force_update     = var.external_dns.force_update

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
resource "helm_release" "nginx_ingress" {
  count = var.nginx_ingress != null ? 1 : 0

  name             = var.nginx_ingress.name
  repository       = local.nginx_ingress.repository
  chart            = local.nginx_ingress.chart
  version          = var.nginx_ingress.version
  namespace        = var.nginx_ingress.namespace
  create_namespace = true
  force_update     = var.nginx_ingress.force_update

  values = var.nginx_ingress.values

  dynamic "set" {
    for_each = var.nginx_ingress.set

    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_list" {
    for_each = var.nginx_ingress.set_list

    content {
      name  = set_list.key
      value = set_list.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.nginx_ingress.set_sensitive

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
  force_update     = var.argo_cd.force_update

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

  depends_on = [helm_release.cert_manager, helm_release.nginx_ingress]
}
