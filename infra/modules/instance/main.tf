resource "azurerm_virtual_machine" "management_server" {
  location            = var.azure_resource_group_location
  resource_group_name = var.azure_resource_group_name
  name                = var.management_instance

  depends_on = [var.network_interface_id]

  network_interface_ids = [var.network_interface_id]
  vm_size               = var.management_vm_size

  storage_image_reference {
    publisher = var.vm_publisher_name
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = "latest"
  }

  storage_os_disk {
    create_option     = "FromImage"
    caching           = "ReadWrite"
    name              = "${var.management_instance}-OS-Disk"
    managed_disk_type = var.storage_tier
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.vm_admin_name}/.ssh/authorized_keys"
      key_data = var.management_ssh_key
    }
  }
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  os_profile {
    admin_username = var.vm_admin_name
    computer_name  = var.management_instance
  }
}
resource "azurerm_virtual_machine" "k8s-master" {
  count                 = var.count-master
  location              = var.azure_resource_group_location
  name                  = "k8s-master-0${count.index + 1}"
  network_interface_ids = [var.k8s-master_network_interface_id[count.index]]
  resource_group_name   = var.azure_resource_group_name
  vm_size               = var.k8s-master_vm_size

  storage_image_reference {
    publisher = var.vm_publisher_name
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = "latest"
  }

  storage_os_disk {
    create_option     = "FromImage"
    caching           = "ReadWrite"
    name              = "${var.k8s-master_instance}-OS-Disk-${count.index + 1}"
    managed_disk_type = var.storage_tier
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.vm_k8s-master_admin_name}/.ssh/authorized_keys"
      key_data = var.k8s-master_ssh_key
    }
  }
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  os_profile {
    admin_username = var.vm_k8s-master_admin_name
    computer_name  = var.k8s-master_instance
  }
}

resource "azurerm_virtual_machine" "k8s-nodes" {
  count                 = var.count-node
  location              = var.azure_resource_group_location
  name                  = "k8s-node-0${count.index + 1}"
  network_interface_ids = [var.k8s-node_network_interface_id[count.index]]
  resource_group_name   = var.azure_resource_group_name
  vm_size               = var.k8s-node_vm_size

  storage_image_reference {
    publisher = var.vm_publisher_name
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = "latest"
  }

  storage_os_disk {
    create_option     = "FromImage"
    caching           = "ReadWrite"
    name              = "${var.k8s-node_instance}-OS-Disk-${count.index + 1}"
    managed_disk_type = var.storage_tier
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.vm_k8s-node_admin_name}/.ssh/authorized_keys"
      key_data = var.k8s-node_ssh_key
    }
  }

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  os_profile {
    admin_username = var.vm_k8s-node_admin_name
    computer_name  = var.k8s-node_instance
  }
}
