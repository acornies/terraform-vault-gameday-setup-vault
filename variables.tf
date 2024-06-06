variable "event_name" {
  type = string
  validation {
    condition     = can(regex("^[-a-zA-Z0-9_]+$", var.event_name))
    error_message = "Event name must only contain alphanumeric characters, dashes, and underscores."
  }
}

variable "namespace_name" {
  type = string
  validation {
    condition     = can(regex("^[-a-zA-Z0-9_]+$", var.namespace_name))
    error_message = "Namespace name must only contain alphanumeric characters, dashes, and underscores."
  }
}

variable "team_name" {
  type = string
  validation {
    condition     = can(regex("^[-a-zA-Z0-9_]+$", var.team_name))
    error_message = "Team name must only contain alphanumeric characters, dashes, and underscores."
  }
}

variable "github_organization" {
  type = string
}

variable "vault_address" {
  type = string
}

variable "vault_token" {
  type = string
  sensitive = true
}