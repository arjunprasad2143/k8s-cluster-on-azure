resource "azurerm_subnet" "public" {
  count                = length(var.public_subnets)
  address_prefix       = var.public_subnets[count.index]
  name                 = "subnet-public-0${count.index + 1}"
  resource_group_name  = var.azure_resource_group_name
  virtual_network_name = var.virtual_network_name

  depends_on = [var.virtual_network_id]
}

resource "azurerm_subnet" "private" {
  count                = length(var.private_subnets)
  address_prefix       = var.private_subnets[count.index]
  name                 = "subnet-private-0${count.index + 1}"
  resource_group_name  = var.azure_resource_group_name
  virtual_network_name = var.virtual_network_name

  depends_on = [var.virtual_network_id]

}