resource "azurerm_management_group" "this" {
  name                       = var.name
  display_name               = var.display_name != "" ? var.display_name : var.name
  parent_management_group_id = var.parent_group_id != "" ? var.parent_group_id : null

  timeouts {
    create = (
      (lookup(local.metadata.resource_timeouts, "azurerm_management_group", null) != null)
      ? (lookup(local.metadata.resource_timeouts["azurerm_management_group"], "create", null) != null)
      ? local.metadata.resource_timeouts["azurerm_management_group"]["create"]
      : local.metadata.resource_timeouts.default.create
      : local.metadata.resource_timeouts.default.create
    )
    read = (
      (lookup(local.metadata.resource_timeouts, "azurerm_management_group", null) != null)
      ? (lookup(local.metadata.resource_timeouts["azurerm_management_group"], "read", null) != null)
      ? local.metadata.resource_timeouts["azurerm_management_group"]["read"]
      : local.metadata.resource_timeouts.default.read
      : local.metadata.resource_timeouts.default.read
    )
    update = (
      (lookup(local.metadata.resource_timeouts, "azurerm_management_group", null) != null)
      ? (lookup(local.metadata.resource_timeouts["azurerm_management_group"], "update", null) != null)
      ? local.metadata.resource_timeouts["azurerm_management_group"]["update"]
      : local.metadata.resource_timeouts.default.update
      : local.metadata.resource_timeouts.default.update
    )
    delete = (
      (lookup(local.metadata.resource_timeouts, "azurerm_management_group", null) != null)
      ? (lookup(local.metadata.resource_timeouts["azurerm_management_group"], "update", null) != null)
      ? local.metadata.resource_timeouts["azurerm_management_group"]["delete"]
      : local.metadata.resource_timeouts.default.delete
      : local.metadata.resource_timeouts.default.delete
    )
  }
}