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
    error_message = "Event name must only contain alphanumeric characters, dashes, and underscores."
  }
}

variable "team_name" {
  type = string
  validation {
    condition     = can(regex("^[-a-zA-Z0-9_]+$", var.team_name))
    error_message = "Event name must only contain alphanumeric characters, dashes, and underscores."
  }
}
# move to data in module consumption
# variable "participants" {
#     type = map(any)
#     validation {
#         condition     = can(alltrue([for value in values(var.participants) : contains(keys(value), "team")]))
#         error_message = "Each participant must have a 'team' key."
#     }
# }

variable "github_organization" {
  type = string
}