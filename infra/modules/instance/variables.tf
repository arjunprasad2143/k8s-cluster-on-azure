variable "azure_resource_group_name" {}
variable "azure_resource_group_location" {}
variable "management_instance" {
  default = "management-server"
}
variable "network_interface_id" {}
variable "management_vm_size" {
  default = "Standard_DS1_v2"
}
variable "vm_publisher_name" {
  default = "Canonical"
}
variable "vm_offer" {
  default = "UbuntuServer"
}
variable "vm_sku" {
  default = "18.04-LTS"
}
variable "storage_tier" {
  default = "Standard_LRS"
}
variable "management_ssh_key" {}
variable "vm_admin_name" {
  default = "k8s-admin"
}
variable "count-master" {}
variable "k8s-master_network_interface_id" {}
variable "k8s-master_vm_size" {
  default = "Standard_DS1_v2"
}
variable "k8s-master_instance" {
  default = "k8s-master"
}
variable "k8s-master_ssh_key" {}
variable "vm_k8s-master_admin_name" {
  default = "k8s-admin"
}
variable "count-node" {}
variable "k8s-node_network_interface_id" {}
variable "k8s-node_vm_size" {
  default = "Standard_DS1_v2"
}
variable "k8s-node_instance" {
  default = "k8s-node"
}
variable "k8s-node_ssh_key" {}
variable "vm_k8s-node_admin_name" {
  default = "k8s-admin"
}
