variable "event_name" {
  type = string
  validation {
    condition     = can(regex("^[-a-zA-Z0-9_]+$", var.event_name))
    error_message = "Event name must only contain alphanumeric characters, dashes, and underscores."
  }
}

variable "participants" {
  type = map(any)
  validation {
    condition     = can(alltrue([for value in values(var.participants) : contains(keys(value), "team")]))
    error_message = "Each participant must have a 'team' key."
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