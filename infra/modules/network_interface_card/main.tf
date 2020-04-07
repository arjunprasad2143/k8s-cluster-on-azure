resource "azurerm_network_interface" "management_vni" {
  location            = var.azure_resource_group_location
  name                = var.management_vni
  resource_group_name = var.azure_resource_group_name
  ip_configuration {
    name                          = var.management_vni_config
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
    public_ip_address_id          = var.management_server_ip_id
  }
}
resource "azurerm_network_interface" "k8s-master_vni" {
  count               = var.count-master
  location            = var.azure_resource_group_location
  name                = "k8s-master-network-interface-0${count.index + 1}"
  resource_group_name = var.azure_resource_group_name
  ip_configuration {
    name                          = "k8s-master-network-interface-config-0${count.index + 1}"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.k8s-master_subnet_id[count.index]
  }
}
resource "azurerm_network_interface" "k8s-node_vni" {
  count               = var.count-node
  location            = var.azure_resource_group_location
  name                = "k8s-node-network-interface-0${count.index + 1}"
  resource_group_name = var.azure_resource_group_name
  ip_configuration {
    name                          = "k8s-node-network-interface-config-0${count.index + 1}"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.k8s-node_subnet_id[count.index]
  }
}