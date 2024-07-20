output "management_group" {
  description = "Management Group object"
  value       = azurerm_management_group.this
}

output "management_group_subscription_association" {
  description = "Management Group Subscription Association object"
  value       = azurerm_management_group_subscription_association.this
}