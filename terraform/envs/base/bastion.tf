resource "tls_private_key" "ssh" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

resource "local_file" "private_key" {
  count    = var.public_ssh_key == "" ? 1 : 0
  content  = tls_private_key.ssh.private_key_pem
  filename = var.filename
}

module "linux" {
  source = "../../modules/terraform-azure-bastion"

  location                   = local.rg_location
  image_os                   = var.image_os
  resource_group_name        = local.rg_name
  allow_extension_operations = false
  # data_disks = [
  #     for i in range(2) : {
  #     name                 = "linuxdisk${i}"
  #     storage_account_type = "Standard_LRS"
  #     create_option        = "Empty"
  #     disk_size_gb         = 1
  #     attach_setting = {
  #         lun     = i
  #         caching = "ReadWrite"
  #     }
  #     disk_encryption_set_id = null
  #     }
  # ]

  new_network_interface = {
    ip_forwarding_enabled = var.ip_forwarding_enabled
    ip_configurations = [
      {
        public_ip_address_id = module.vnet.bastion_pip
        primary              = true
      }
    ]
  }
  admin_username = "${local.prefix_name}-${var.admin_username_bastion}"
  admin_ssh_keys = [
    {
      public_key = tls_private_key.ssh.public_key_openssh
    }
  ]
  name = "${local.prefix_name}-${var.bastion_vm_name}"
  os_disk = {
    caching              = var.caching
    storage_account_type = var.storage_account_os_type
  }
  os_simple = var.os_simple
  size      = var.size
  subnet_id = module.vnet.bastion_subnet
  zone      = var.zone

}

resource "azurerm_network_interface_security_group_association" "linux_nic" {
  network_interface_id      = module.linux.network_interface_id
  network_security_group_id = module.vnet.network_security_group_id
}