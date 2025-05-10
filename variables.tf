variable "argo_cd" {
  description = "Argo CD configs"
  type = object({
    enable        = optional(bool, true)
    name          = optional(string, "argo-cd")
    version       = optional(string, null)
    namespace     = optional(string, null)
    values        = optional(list(string), [])
    set           = optional(map(string), {})
    set_list      = optional(map(list(string)), {})
    set_sensitive = optional(map(string), {})
    force_update  = optional(bool, false)
  })
  default = {
    enable = false
  }
}

variable "cert_manager" {
  description = "Cert manager configs"
  type = object({
    enable        = optional(bool, true)
    name          = optional(string, "cert-manager")
    version       = optional(string, null)
    namespace     = optional(string, null)
    values        = optional(list(string), [])
    set           = optional(map(string), {})
    set_list      = optional(map(list(string)), {})
    set_sensitive = optional(map(string), {})
    force_update  = optional(bool, false)
  })
  default = {
    enable = false
  }
}

variable "external_dns" {
  description = "External DNS configs"
  type = object({
    enable        = optional(bool, true)
    name          = optional(string, "external-dns")
    version       = optional(string, null)
    namespace     = optional(string, null)
    values        = optional(list(string), [])
    set           = optional(map(string), {})
    set_list      = optional(map(list(string)), {})
    set_sensitive = optional(map(string), {})
    force_update  = optional(bool, false)
  })
  default = {
    enable = false
  }
}

variable "istio" {
  description = "Istio configs"
  type = object({
    enable        = optional(bool, true)
    name          = optional(string, "istio")
    version       = optional(string, null)
    namespace     = optional(string, "istio-system")
    mode          = optional(string, "ambient")
    values        = optional(list(string), [])
    set           = optional(map(string), {})
    set_list      = optional(map(list(string)), {})
    set_sensitive = optional(map(string), {})
    force_update  = optional(bool, false)
  })
  default = {
    enable = false
  }

  validation {
    condition     = contains(["sidecar", "ambient"], var.istio.mode)
    error_message = "Istio mode should be either 'sidecar' or 'ambient'"
  }
}

variable "karpenter" {
  description = "Karpenter configs"
  type = object({
    enable        = optional(bool, true)
    name          = optional(string, "karpenter")
    version       = optional(string, null)
    namespace     = optional(string, null)
    values        = optional(list(string), [])
    set           = optional(map(string), {})
    set_list      = optional(map(list(string)), {})
    set_sensitive = optional(map(string), {})
    force_update  = optional(bool, false)
  })
  default = {
    enable = false
  }
}
