variable "argo_cd" {
  description = "Argo CD configs"
  type = object({
    name          = optional(string, "argo-cd")
    version       = optional(string, null)
    namespace     = optional(string, null)
    values        = optional(list(string), [])
    set           = optional(map(string), {})
    set_list      = optional(map(list(string)), {})
    set_sensitive = optional(map(string), {})
    force_update  = optional(bool, false)
  })
  default = null
}

variable "cert_manager" {
  description = "Cert manager configs"
  type = object({
    name          = optional(string, "cert-manager")
    version       = optional(string, null)
    namespace     = optional(string, null)
    values        = optional(list(string), [])
    set           = optional(map(string), {})
    set_list      = optional(map(list(string)), {})
    set_sensitive = optional(map(string), {})
    force_update  = optional(bool, false)
  })
  default = null
}

variable "external_dns" {
  description = "External DNS configs"
  type = object({
    name          = optional(string, "external-dns")
    version       = optional(string, null)
    namespace     = optional(string, null)
    values        = optional(list(string), [])
    set           = optional(map(string), {})
    set_list      = optional(map(list(string)), {})
    set_sensitive = optional(map(string), {})
    force_update  = optional(bool, false)
  })
  default = null
}

variable "nginx_ingress" {
  description = "NGINX Ingress configs"
  type = object({
    name          = optional(string, "ingress-nginx")
    version       = optional(string, null)
    namespace     = optional(string, null)
    values        = optional(list(string), [])
    set           = optional(map(string), {})
    set_list      = optional(map(list(string)), {})
    set_sensitive = optional(map(string), {})
    force_update  = optional(bool, false)
  })
  default = null
}

variable "karpenter" {
  description = "Karpenter configs"
  type = object({
    name          = optional(string, "karpenter")
    version       = optional(string, null)
    namespace     = optional(string, null)
    values        = optional(list(string), [])
    set           = optional(map(string), {})
    set_list      = optional(map(list(string)), {})
    set_sensitive = optional(map(string), {})
    force_update  = optional(bool, false)
  })
  default = null
}
