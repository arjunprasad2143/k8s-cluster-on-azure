output "management-server_network_interface_id" {
  value = azurerm_network_interface.management_vni.id
}
output "k8s-master_network_interface_id" {
  value = azurerm_network_interface.k8s-master_vni.*.id
}
output "k8s-node_network_interface_id" {
  value = azurerm_network_interface.k8s-node_vni.*.id
}
output "k8s-master-ips" {
  value = azurerm_network_interface.k8s-master_vni.*.private_ip_address
}

output "k8s-node-ips" {
  value = azurerm_network_interface.k8s-node_vni.*.private_ip_address
}

output "management-server-ip" {
  value = azurerm_network_interface.management_vni.private_ip_address
}