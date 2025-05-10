### Karpenter
resource "helm_release" "karpenter" {
  count = var.karpenter.enable ? 1 : 0

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


### Istio
resource "helm_release" "istio" {
  count = var.istio.enable ? 1 : 0

  name             = var.istio.name
  repository       = local.istio.repository
  chart            = local.istio.chart[var.istio.mode]
  version          = var.istio.version
  namespace        = var.istio.namespace
  create_namespace = true
  force_update     = var.istio.force_update

  values = var.istio.values

  dynamic "set" {
    for_each = var.istio.mode == "ambient" ? ["base.", "istiod.", "ztunnel."] : [""]

    content {
      name  = "${set.value}global.istioNamespace"
      value = var.istio.namespace
    }
  }

  dynamic "set" {
    for_each = var.istio.mode == "sidecar" ? [true] : []

    content {
      name  = "pilot.cni.enabled"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = var.istio.set

    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_list" {
    for_each = var.istio.set_list

    content {
      name  = set_list.key
      value = set_list.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.istio.set_sensitive

    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  depends_on = [helm_release.istio-cni]
}

resource "helm_release" "istio-base" {
  count = var.istio.enable && var.istio.mode == "sidecar" ? 1 : 0

  name             = "${var.istio.name}-base"
  repository       = local.istio.repository
  chart            = "base"
  namespace        = var.istio.namespace
  create_namespace = true

  set {
    name  = "global.istioNamespace"
    value = var.istio.namespace
  }

  depends_on = [helm_release.karpenter]
}

resource "helm_release" "istio-cni" {
  count = var.istio.enable && var.istio.mode == "sidecar" ? 1 : 0

  name             = "${var.istio.name}-cni"
  repository       = local.istio.repository
  chart            = "cni"
  namespace        = var.istio.namespace
  create_namespace = true

  depends_on = [helm_release.istio-base]
}


### Cert manager
resource "helm_release" "cert_manager" {
  count = var.cert_manager.enable ? 1 : 0

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
  count = var.external_dns.enable ? 1 : 0

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


### Argo CD
resource "helm_release" "argo_cd" {
  count = var.argo_cd.enable ? 1 : 0

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

  depends_on = [helm_release.cert_manager, helm_release.external_dns, helm_release.istio]
}
