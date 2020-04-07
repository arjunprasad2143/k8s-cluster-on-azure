provider "azurerm" {
  features {}
  version         = "~> 2.0"
}

data "azurerm_resource_group" "rg" {
  name = var.azure_resource_group_name
}

module "network" {
  source                        = "./modules/network"
  vn_name                       = var.vn_name
  azure_resource_group_name     = var.azure_resource_group_name
  azure_resource_group_location = var.azure_resource_group_location
}
module "subnets" {
  source                        = "./modules/subnets"
  azure_resource_group_location = var.azure_resource_group_location
  azure_resource_group_name     = var.azure_resource_group_name
  virtual_network_name          = var.vn_name
  virtual_network_id            = module.network.virtual_network_id
  public_subnets                = var.public_subnets
  private_subnets               = var.private_subnets
}
module "public_ip" {
  source                        = "./modules/public_ip"
  azure_resource_group_location = var.azure_resource_group_location
  azure_resource_group_name     = var.azure_resource_group_name
  management_vm_id              = module.instance.management_vm_id
}
module "network_security_group" {
  source                        = "./modules/network_security_group"
  azure_resource_group_location = var.azure_resource_group_location
  azure_resource_group_name     = var.azure_resource_group_name
  subnet_id_private             = module.subnets.subnet_id_private.*
  subnet_id_public              = module.subnets.subnet_id_public[0]
  count_nsg                     = var.master-server-count
}

module "network_interface_card" {
  source                        = "./modules/network_interface_card"
  azure_resource_group_location = var.azure_resource_group_location
  azure_resource_group_name     = var.azure_resource_group_name
  subnet_id                     = module.subnets.subnet_id_public[0]
  k8s-master_subnet_id          = module.subnets.subnet_id_private.*
  management_server_ip_id       = module.public_ip.management_server_ip_id
  count-master                  = var.master-server-count
  count-node                    = var.node-server-count
  k8s-node_subnet_id            = module.subnets.subnet_id_private.*
}

module "instance" {
  source                        = "./modules/instance"
  azure_resource_group_location = var.azure_resource_group_location
  azure_resource_group_name     = var.azure_resource_group_name
  #Management Server
  network_interface_id = module.network_interface_card.management-server_network_interface_id
  management_ssh_key   = var.management_ssh_keys
  #k8s Master
  count-master                    = var.master-server-count
  k8s-master_network_interface_id = module.network_interface_card.k8s-master_network_interface_id.*
  k8s-master_ssh_key              = var.k8s-master_ssh_key
  #k8s Node
  count-node                    = var.node-server-count
  k8s-node_network_interface_id = module.network_interface_card.k8s-node_network_interface_id.*
  k8s-node_ssh_key              = var.k8s-node_ssh_key
}

resource "null_resource" "ansible_inventory_list" {
  depends_on = [module.instance.k8s-master-id, module.instance.k8s-node-id]

  #Create k8s-master-inventory
  provisioner "local-exec" {
    command = "echo \"\n[kube-master]\" > k8s-inventory.ini"
  }
  provisioner "local-exec" {
    command = "echo \"${join("\n", formatlist("%s ansible_host=%s", module.instance.k8s-master-hostname, module.network_interface_card.k8s-master-ips))}\" >> k8s-inventory.ini"
  }
  #Create k8s-master-inventory
  provisioner "local-exec" {
    command = "echo \"\n[etcd]\" >> k8s-inventory.ini"
  }
  provisioner "local-exec" {
    command = "echo \"${join("\n", formatlist("%s ansible_host=%s", module.instance.k8s-master-hostname, module.network_interface_card.k8s-master-ips))}\" >> k8s-inventory.ini"
  }
  #Create k8s-master-inventory
  provisioner "local-exec" {
    command = "echo \"\n[kube-node]\" >> k8s-inventory.ini"
  }
  provisioner "local-exec" {
    command = "echo \"${join("\n", formatlist("%s ansible_host=%s", module.instance.k8s-node-hostname, module.network_interface_card.k8s-node-ips))}\" >> k8s-inventory.ini"
  }
  provisioner "local-exec" {
    command = "echo \"\n[k8s-cluster:children]\nkube-node\nkube-master\" >> k8s-inventory.ini"
  }
  provisioner "file" {
    source = "k8s-inventory.ini"
    destination = "/home/k8s-admin/k8s-inventory.ini"

    connection {
      type = "ssh"
      user = "k8s-admin"
      private_key = file("~/.ssh/id_rsa")
      port = "22"
      host = module.public_ip.management_server_ip
    }
  }

  provisioner "file" {
    source = "requirements.txt"
    destination = "/home/k8s-admin/requirements.txt"

    connection {
      type = "ssh"
      user = "k8s-admin"
      private_key = file("~/.ssh/id_rsa")
      port = "22"
      host = module.public_ip.management_server_ip
    }
  }

  provisioner "file" {
    source = "~/.ssh/id_rsa"
    destination = "/home/k8s-admin/id_rsa"

    connection {
      type = "ssh"
      user = "k8s-admin"
      private_key = file("~/.ssh/id_rsa")
      port = "22"
      host = module.public_ip.management_server_ip
    }
  }
  provisioner "file" {
    source = "init.sh"
    destination = "/home/k8s-admin/init.sh"

    connection {
      type = "ssh"
      user = "k8s-admin"
      private_key = file("~/.ssh/id_rsa")
      port = "22"
      host = module.public_ip.management_server_ip
    }
  }

  provisioner "remote-exec" {
    connection {
     type = "ssh"
      user = "k8s-admin"
      private_key = file("~/.ssh/id_rsa")
      port = "22"
      host = module.public_ip.management_server_ip
    }
    inline = [
      "/bin/bash -x /home/k8s-admin/init.sh"
    ]
  }
}

