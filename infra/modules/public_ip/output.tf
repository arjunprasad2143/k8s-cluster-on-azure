
output "management_server_ip" {
  value = azurerm_public_ip.management_ip.ip_address
}
output "management_server_ip_id" {
  value = azurerm_public_ip.management_ip.id
}