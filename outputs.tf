output "vault_namespaces" {
  value = {
    facilitator  = vault_namespace.facilitator.path_fq
    participants = { for key, value in var.participants : key => vault_namespace.participants[key].path_fq }
  }
}

output "facilitator_namespace" {
  value = vault_namespace.facilitator.path_fq
}