variable "name" {
  description = "The name or UUID for this Management Group, which needs to be unique across your tenant. A new UUID will be generated if not provided. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition = can(
      regex(
        lookup(
          local.metadata.validator_expressions,
          "management_group_name",
          local.metadata.validator_expressions["default"]
        ), var.name
      )
    )
    error_message = format(
      lookup(
        local.metadata.validator_error_messages,
        "management_group_name",
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

variable "budgets" {
  description = "List of budgets to be assigned under management group."
  type = list(object({
    name       = string
    amount     = number
    time_grain = string
    start_date = string
    end_date   = string
    filter = object({
      dimension = list(object({
        name   = string
        values = list(string)
      }))
      tag = list(object({
        name   = string
        values = list(string)
      }))
    })
    notifications = list(object({
      enabled        = bool
      threshold      = number
      operator       = string
      threshold_type = string
      contact_emails = list(string)
    }))
  }))
  default = []

}

// Define the module input metadata variable
variable "metadata" {
  description = "Module metadata object to give user possibility to override default module values."
  type = object({
    resource_timeouts        = optional(map(map(string)), {})
    validator_error_messages = optional(map(string), {})
    validator_expressions    = optional(map(string), {})
  })
  default = {}

  validation {
    condition = alltrue(
      flatten([
        for value in var.metadata.resource_timeouts : [
          for timeout in value : timeout != null
          ? can(
            regex(
              local.definitions.validator_expressions["timeout_value"],
              timeout
            )
          )
          : true
        ]
      ])
    )
    error_message = lookup(
      local.definitions.validator_error_messages,
      "timeout_value",
      local.definitions.validator_error_messages["default"]
    )
  }

  validation {
    condition = alltrue(
      flatten([
        for value in var.metadata.resource_timeouts : [
          for key, timeout in value : timeout != null
          ? can(
            regex(
              local.definitions.validator_expressions["timeout_key"],
              key
            )
          )
          : true
        ]
      ])
    )
    error_message = lookup(
      local.definitions.validator_error_messages,
      "timeout_key",
      local.definitions.validator_error_messages["default"]
    )
  }
}

