terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/vault"
      version = "4.2.0"
    }
  }
}

# Create the participant namespace
resource "vault_namespace" "participant" {
  path = var.namespace_name
}

# Create a "sudo" policy in the namespace
resource "vault_policy" "participant" {
  namespace = vault_namespace.participant.path_fq
  name      = "admin"
  policy    = <<EOT
path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}

# Create a GitHub auth backend in the namespace under path "github"
resource "vault_github_auth_backend" "participant" {
  namespace    = vault_namespace.participant.path_fq
  organization = var.github_organization
}

# Use the team name variable to assign the appropriate GitHub
# team for the GitHub auth backend for the namespace, assign it the "admin" policy
resource "vault_github_team" "participant" {
  namespace = vault_namespace.participant.path_fq
  backend   = vault_github_auth_backend.participant.id
  team      = var.team_name
  policies  = ["admin"]
}

# Create the secrets v2 engine in the particpant namespace under path "kv"
resource "vault_mount" "participant" {
  namespace = vault_namespace.participants.path_fq
  path      = "kv"
  type      = "kv"
  options = {
    version = "2"
  }
}