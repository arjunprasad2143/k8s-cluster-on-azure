variable "azure_resource_group_name" {}
variable "azure_resource_group_location" {}
variable "management_public_ip" {
  default = "management-server-public-ip"
}
variable "management_vm_id" {}