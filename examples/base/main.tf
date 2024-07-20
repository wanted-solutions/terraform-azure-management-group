provider "azurerm" {
  features {}
}

module "management_group" {
    source  = "../.."
    name = "example-management-group"
    display_name = "Example Management Group"
}
