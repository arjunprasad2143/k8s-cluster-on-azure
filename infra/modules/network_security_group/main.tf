resource "azurerm_network_security_group" "nsg-public" {
  location            = var.azure_resource_group_location
  name                = var.nsg_public_name
  resource_group_name = var.azure_resource_group_name

  security_rule {
    description                = "SSH security group"
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = var.security_rule_name
    priority                   = 100
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "nsg-private" {
  location            = var.azure_resource_group_location
  name                = var.nsg_private_name
  resource_group_name = var.azure_resource_group_name

  security_rule {
    description                = "All open ports between subnets"
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = var.security_rule_name_1
    priority                   = 100
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-public-subnet" {
  network_security_group_id = azurerm_network_security_group.nsg-public.id

  depends_on = [var.subnet_id_public]

  subnet_id = var.subnet_id_public
}

resource "azurerm_subnet_network_security_group_association" "nsg-private-subnet" {
  count                     = var.count_nsg
  network_security_group_id = azurerm_network_security_group.nsg-private.id

  depends_on = [var.subnet_id_private]

  subnet_id = var.subnet_id_private[count.index]

}