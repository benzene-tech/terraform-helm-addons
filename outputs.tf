output "argo_cd" {
  description = "Argo CD configs"
  value       = one(helm_release.argo_cd[*])
}

output "cert_manager" {
  description = "Cert manager configs"
  value       = one(helm_release.cert_manager[*])
}

output "external_dns" {
  description = "External DNS configs"
  value       = one(helm_release.external_dns[*])
}

output "istio" {
  description = "Istio configs"
  value       = one(helm_release.istio[*])
}

output "karpenter" {
  description = "Karpenter configs"
  value       = one(helm_release.karpenter[*])
}
