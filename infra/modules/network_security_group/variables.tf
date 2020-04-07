variable "azure_resource_group_name" {}
variable "azure_resource_group_location" {}
variable "nsg_public_name" {
  default = "SSH_SG"
}
variable "security_rule_name" {
  default = "ssh_rule"
}
variable "subnet_id_public" {}
variable "nsg_private_name" {
  default = "ALL_OPEN_SG"
}
variable "security_rule_name_1" {
  default = "all_open_rule"
}
variable "subnet_id_private" {}
variable "count_nsg" {}
