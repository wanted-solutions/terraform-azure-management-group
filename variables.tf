variable "name" {
  description = "The name or UUID for this Management Group, which needs to be unique across your tenant. A new UUID will be generated if not provided. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition = can(
      regex(
        lookup(
          var.metadata.validators,
          "name",
          var.metadata.default_validator
        ),
        var.name
      )
    )
    error_message = lookup(
      var.metadata.error_messages,
      "name",
      var.metadata.default_error_message
    )
  }
}

variable "display_name" {
  description = "A friendly name for this Management Group. If not specified, this will be the same as the \"name\" variable."
  type        = string
  default     = ""
}

variable "parent_group_id" {
  description = "The parent management group ID of the resource group to create."
  type        = string
  default     = ""
}

variable "subscription_ids" {
  description = "List of subscription IDs to be assigned under management group."
  type        = list(string)
  default     = []
}

variable "metadata" {
  description = "Metadata object TBA"
  type = object({
    default_error_message = optional(string, "Unknown error during validation has occured.")
    default_validator     = optional(string, ".*")
    error_messages        = optional(map(string), {})
    validators            = optional(map(string), {})
    timeouts = optional(object({
      create = optional(string, "30m")
      read   = optional(string, "5m")
      update = optional(string, "30m")
      delete = optional(string, "30m")
    }), {})
  })
  default = {
    error_messages = {
      timeouts = "Timeout object \"%s\" key must be defined as a one to three characters duration string and unit one letter suffix for minutes or hours, ie. 30m, 3h..."
    }
    validators = {
      timeouts = "^(\\d{1,3}[m,h])$"
    }
  }

  validation {
    condition = can(
      regex(
        var.metadata.validators["timeouts"],
        var.metadata.timeouts["create"]
      )
    )
    error_message = format(
      var.metadata.error_messages["timeouts"],
      "create"
    )
  }

  validation {
    condition = can(
      regex(
        var.metadata.validators["timeouts"],
        var.metadata.timeouts["read"]
      )
    )
    error_message = format(
      var.metadata.error_messages["timeouts"],
      "read"
    )
  }

  validation {
    condition = can(
      regex(
        var.metadata.validators["timeouts"],
        var.metadata.timeouts["update"]
      )
    )
    error_message = format(
      var.metadata.error_messages["timeouts"],
      "update"
    )
  }

  validation {
    condition = can(
      regex(
        var.metadata.validators["timeouts"],
        var.metadata.timeouts["delete"]
      )
    )
    error_message = format(
      var.metadata.error_messages["timeouts"],
      "delete"
    )
  }
}