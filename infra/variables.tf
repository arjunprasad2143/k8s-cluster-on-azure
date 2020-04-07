variable "azure_resource_group_name" {
  description = "Azure Resource Group Name"
  default     = "xxxxxxxxxxxxxxxxx"
}
variable "azure_resource_group_location" {
  description = "Azure Resource Group Location"
  default     = "West Europe"
}

#Module specific variables
variable "vn_name" {}

variable "vn_address_space" {}
variable "public_subnets" {
  type    = list(string)
  default = []
}
variable "private_subnets" {
  type    = list(string)
  default = []
}
variable "management_ssh_keys" {}
variable "master-server-count" {}
variable "k8s-master_ssh_key" {}
variable "node-server-count" {}
variable "k8s-node_ssh_key" {}
variable "terraform_token" {}
