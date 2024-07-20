locals {
  defaults = {
    resource_timeouts = merge({
      default = {
        create = "30m"
        read   = "5m"
        update = "30m"
        delete = "30m"
      }
    })
    validator_error_messages = merge({ 
        default = "Unknown error during validation has occured."
        timeout = "Timeout value is not valid."
    })
    validator_expressions = merge({
        default = ".*"
        timeout = "^[0-9]+[smh]$"
    })
  }
  metadata = {
    validator_error_messages = merge(
      local.defaults.validator_error_messages,
      length(data.consul_keys.metadata) > 0 ? jsondecode(data.consul_keys.metadata) : {},
      var.metadata.validator_error_messages
    )
    validator_expressions = merge(
      local.defaults.validator_expressions,
      length(data.consul_keys.metadata) > 0 ? jsondecode(data.consul_keys.metadata) : {},
      var.metadata.validator_expressions
    )
    resource_timeouts = merge(
      local.defaults.resource_timeouts,
      length(data.consul_keys.metadata) > 0 ? jsondecode(data.consul_keys.metadata) : {},
      var.metadata.resource_timeouts
    )
  }
}