variable "name" {
  description = "The name or UUID for this Management Group, which needs to be unique across your tenant. A new UUID will be generated if not provided. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition = can(
      regex(
        lookup(
          local.metadata.validator_expressions, "management_group_name",
          local.metadata.validator_expressions["default"]
        ), var.name
      )
    )
    error_message = format(
      lookup(
        local.metadata.validator_error_messages, "management_group_name",
        local.metadata.validator_error_messages["default"]
      )
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
  description = "Module metadata object to give user possibility to override default module values."
  type = object({
    module_external_metadata = optional(object({
      format = optional(string, "json")
      source = optional(string, "file")
    }), {})
    resource_timeouts = optional(map(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    })), {})
    validator_error_messages = optional(map(string), {})
    validator_expressions    = optional(map(string), {})
  })
  default = {
    resource_timeouts = {
      "name" = {
        "create" = "30m"
        "update" = "30s"
      }
    }
  }

  validation {
    condition = alltrue(
      flatten([
        for key, value in var.metadata.resource_timeouts : [
          for timeout in value : timeout != null
          ? can(
            regex(
              local.definitions.validator_expressions["timeout"],
              timeout
            )
          )
          : true
        ]
      ])
    )
    error_message = format(
      local.definitions.validator_error_messages["timeout"]
    )
  }
}