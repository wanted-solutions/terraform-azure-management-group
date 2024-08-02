locals {
  definitions = {
    resource_timeouts = merge({
      default = {
        create = "30m"
        read   = "5m"
        update = "30m"
        delete = "30m"
      }
    })
    validator_error_messages = {
      default       = "Unknown error during validation has occured."
      timeout_key   = "Timeout key is not valid, please check your \"metadata\" object, only \"create\", \"read\", \"update\" and \"delete\" can be used as metadata key value."
      timeout_value = "Timeout value is not in valid format, please check your \"metadata\" object."
    }
    validator_expressions = {
      default       = ".*"
      timeout_key   = "^(create|read|update|delete)$"
      timeout_value = "^[0-9]+[smh]$"
    }
  }
  defaults = {
    validator_error_messages = merge(
      local.definitions.validator_error_messages,
      (length(data.consul_keys.metadata) > 0) 
        ? jsondecode(data.consul_keys.metadata["validator_error_messages"]) 
        : {}
    )
    validator_expressions = merge(
      local.definitions.validator_expressions,
      (length(data.consul_keys.metadata) > 0) 
        ? jsondecode(data.consul_keys.metadata["validator_expressions"]) 
        : {}
    )
    resource_timeouts = merge(
      local.definitions.resource_timeouts,
      (length(data.consul_keys.metadata) > 0) 
        ? jsondecode(data.consul_keys.metadata["resource_timeouts"]) 
        : {}
    )
  }
  metadata = {
    validator_error_messages = merge(
      local.definitions.validator_error_messages,
      length(data.consul_keys.metadata) > 0 ? jsondecode(data.consul_keys.metadata) : {},
      var.metadata.validator_error_messages
    )
    validator_expressions = merge(
      local.definitions.validator_expressions,
      length(data.consul_keys.metadata) > 0 ? jsondecode(data.consul_keys.metadata) : {},
      var.metadata.validator_expressions
    )
    resource_timeouts = merge(
      local.definitions.resource_timeouts,
      length(data.consul_keys.metadata) > 0 ? jsondecode(data.consul_keys.metadata) : {},
      var.metadata.resource_timeouts
    )
  }
}