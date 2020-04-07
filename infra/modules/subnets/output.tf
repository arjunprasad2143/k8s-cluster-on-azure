output "subnet_id_public" {
  value = azurerm_subnet.public.*.id
}
output "subnet_id_private" {
  value = azurerm_subnet.private.*.id
}



