output "management_vm_id" {
  value = azurerm_virtual_machine.management_server.id
}
output "management-hostname" {
  value = azurerm_virtual_machine.management_server.name
}
output "k8s-master-hostname" {
  value = azurerm_virtual_machine.k8s-master.*.name
}
output "k8s-node-hostname" {
  value = azurerm_virtual_machine.k8s-nodes.*.name
}
output "k8s-master-id" {
  value = azurerm_virtual_machine.k8s-master.*.id
}
output "k8s-node-id" {
  value = azurerm_virtual_machine.k8s-nodes.*.id
}