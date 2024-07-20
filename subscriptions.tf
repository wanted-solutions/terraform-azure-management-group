resource "azurerm_management_group_subscription_association" "this" {
  for_each = {
    for subscription_id in var.subscription_ids : subscription_id => subscription_id
  }

  management_group_id = azurerm_management_group.this.id
  subscription_id     = each.value

  /*timeouts {
    create = var.metadata.timeouts.create
    read   = var.metadata.timeouts.read
    delete = var.metadata.timeouts.delete
  }*/
}