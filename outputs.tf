output "management_group" {
  description = "Management Group object"
  value       = azurerm_management_group.this
}

output "management_group_subscription_association" {
  description = "Management Group Subscription Association object"
  value       = azurerm_management_group_subscription_association.this
}

output "management_group_consumption_budget" {
  description = "Consumption Budget Management Group object"
  value       = azurerm_consumption_budget_management_group.this
}