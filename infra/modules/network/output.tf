
output "virtual_network_id" {
  value = azurerm_virtual_network.vn.id
}
output "vnet_address" {
  value = azurerm_virtual_network.vn.address_space
}
output "vnet_name" {
  value = azurerm_virtual_network.vn.name
}