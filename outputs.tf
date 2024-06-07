output "vault_namespaces" {
  value = vault_namespace.participants[*].path_fq
}