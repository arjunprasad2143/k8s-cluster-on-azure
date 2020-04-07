variable "azure_resource_group_name" {}
variable "azure_resource_group_location" {}
variable "management_vni" {
  default = "management-server-network-interface"
}
variable "management_vni_config" {
  default = "management-server-network-interface-config"
}
variable "subnet_id" {}
variable "management_server_ip_id" {}
variable "count-master" {}
variable "k8s-master_subnet_id" {}
variable "count-node" {}
variable "k8s-node_subnet_id" {}