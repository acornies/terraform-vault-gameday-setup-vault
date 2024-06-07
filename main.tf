terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.2.0"
    }
  }
}

provider "vault" {
  address = var.vault_address
  token   = var.vault_token
  namespace = "admin" #TODO for non-hcp vault clusters
  skip_child_token = true
}

# Create namespace for the facilitator
resource "vault_namespace" "facilitator" {
  path = "${var.event_name}-facilitator"
}

# Create the participant namespaces from the map defined in variables.tf
resource "vault_namespace" "participants" {
  for_each = var.participants
  path     = each.key
}

# Create a "sudo" policy in each namespace
resource "vault_policy" "participants" {
  for_each  = var.participants
  namespace = vault_namespace.participants[each.key].path_fq
  name      = "admin"
  policy    = <<EOT
path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}

# Create a GitHub auth backend in each namespace under path "github"
resource "vault_github_auth_backend" "participants" {
  for_each     = var.participants
  namespace    = vault_namespace.participants[each.key].path_fq
  organization = var.github_organization
}

# Use the "team" property in the participants variable to assign the appropriate GitHub
# team for the GitHub auth backend for each namespace, assign it the "dev" policy
resource "vault_github_team" "participants" {
  for_each  = var.participants
  namespace = vault_namespace.participants[each.key].path_fq
  backend   = vault_github_auth_backend.participants[each.key].id
  team      = each.value.team
  policies  = ["admin"]
}

# Create the secrets v2 engine in each particpant namespace under path "kv"
resource "vault_mount" "participants" {
  for_each  = var.participants
  namespace = vault_namespace.participants[each.key].path_fq
  path      = "kv"
  type      = "kv"
  options = {
    version = "2"
  }
}