data "azurerm_resource_group" "rg" {
  name     = var.azure_resource_group_name
}

resource "azurerm_virtual_network" "vn" {
  name                = var.vn_name
  address_space       = [var.vn_address_space]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

}

