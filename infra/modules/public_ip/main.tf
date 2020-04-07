resource "azurerm_public_ip" "management_ip" {
  location            = var.azure_resource_group_location
  name                = var.management_public_ip
  resource_group_name = var.azure_resource_group_name
  allocation_method   = "Static"
}
