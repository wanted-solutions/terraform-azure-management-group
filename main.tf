resource "azurerm_management_group" "this" {
  name                       = var.name
  display_name               = var.display_name != "" ? var.display_name : var.name
  parent_management_group_id = var.parent_group_id != "" ? var.parent_group_id : null

  timeouts {
    create = var.metadata.timeouts.create
    read   = var.metadata.timeouts.read
    update = var.metadata.timeouts.update
    delete = var.metadata.timeouts.delete
  }
}