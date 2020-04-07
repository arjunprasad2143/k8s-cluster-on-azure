output "management_server_ip" {
  value = module.public_ip.management_server_ip
}

output "k8s-master-ips" {
  value = module.network_interface_card.k8s-master-ips
}

output "k8s-node-ips" {
  value = module.network_interface_card.k8s-node-ips
}

output "k8s-master-hostname-ip" {
  value = "${join("\t\n", module.instance.k8s-master-hostname)}"
}
output "k8s-node-hostname-ip" {
  value = "${join("\t\n", module.instance.k8s-node-hostname)}"
}
