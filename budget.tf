resource "azurerm_consumption_budget_management_group" "this" {
  for_each = {
    for budget in var.budgets : budget.name => budget
  }
  name                = each.value.name
  management_group_id = azurerm_management_group.this.id

  amount     = each.value.amount
  time_grain = each.value.time_grain

  time_period {
    start_date = each.value.start_date
    end_date   = each.value.end_date
  }

  filter {
    dynamic "dimension" {
      for_each = {
        for dimension in each.value.filter.dimensions : dimension.name => dimension
      }
      content {
        name   = dimension.name
        values = dimension.value
      }

    }

    dynamic "tag" {
      for_each = {
        for tag in each.value.filter.tag : tag.name => tag
      }
      content {
        name   = tag.name
        values = tag.values
      }

    }
  }

  dynamic "notification" {
    for_each = {
      for notification in each.value.notifications : notification.name => notification
    }
    content {
      enabled        = notification.enabled
      threshold      = notification.threshold
      operator       = notification.operator
      threshold_type = notification.threshold_type
      contact_emails = notification.contact_emails
    }
  }

  timeouts {
    create = (
      (lookup(local.metadata.resource_timeouts, "azurerm_consumption_budget_management_group", null) != null)
      ? (lookup(local.metadata.resource_timeouts["azurerm_consumption_budget_management_group"], "create", null) != null)
      ? local.metadata.resource_timeouts["azurerm_consumption_budget_management_group"]["create"]
      : local.metadata.resource_timeouts.default.create
      : local.metadata.resource_timeouts.default.create
    )
    read = (
      (lookup(local.metadata.resource_timeouts, "azurerm_consumption_budget_management_group", null) != null)
      ? (lookup(local.metadata.resource_timeouts["azurerm_consumption_budget_management_group"], "read", null) != null)
      ? local.metadata.resource_timeouts["azurerm_consumption_budget_management_group"]["read"]
      : local.metadata.resource_timeouts.default.read
      : local.metadata.resource_timeouts.default.read
    )
    update = (
      (lookup(local.metadata.resource_timeouts, "azurerm_consumption_budget_management_group", null) != null)
      ? (lookup(local.metadata.resource_timeouts["azurerm_consumption_budget_management_group"], "update", null) != null)
      ? local.metadata.resource_timeouts["azurerm_consumption_budget_management_group"]["update"]
      : local.metadata.resource_timeouts.default.update
      : local.metadata.resource_timeouts.default.update
    )
    delete = (
      (lookup(local.metadata.resource_timeouts, "azurerm_consumption_budget_management_group", null) != null)
      ? (lookup(local.metadata.resource_timeouts["azurerm_consumption_budget_management_group"], "delete", null) != null)
      ? local.metadata.resource_timeouts["azurerm_consumption_budget_management_group"]["delete"]
      : local.metadata.resource_timeouts.default.delete
      : local.metadata.resource_timeouts.default.delete
    )
  }
}