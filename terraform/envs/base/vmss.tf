resource "azurerm_orchestrated_virtual_machine_scale_set" "vmss" {
  location                    = local.rg_location
  name                        = "${local.prefix_name}-${var.vmss_name}"
  platform_fault_domain_count = var.platform_fault_domain_count
  resource_group_name         = local.rg_name
  zones                         = var.vmss_zone

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_os_type
  }
}

module "linux_server" {
  source = "../../modules/terraform-azure-bastion"

  location                   = var.rg_location
  image_os                   = var.image_os
  resource_group_name        = local.rg_name
  allow_extension_operations = var.allow_extention_operations
  boot_diagnostics           = var.boot_diagnostic_vmss
  new_network_interface = {
    ip_forwarding_enabled = var.ip_forwarding_enabled
    ip_configurations = [
      {
        primary = true
      }
    ]
  }
  admin_username = "${local.prefix_name}-${var.admin_username_server}"
  admin_ssh_keys = [
    {
      public_key = tls_private_key.ssh_serser.public_key_openssh
    }
  ]
  name = "${local.prefix_name}-${var.vmss_vm_name}"
  os_disk = {
    caching              = var.caching
    storage_account_type = var.storage_account_os_type
  }
  zone                         = var.vmss_vm_zone
  os_simple                    = var.os_simple
  size                         = var.size
  subnet_id                    = module.vnet.server_subnet
  virtual_machine_scale_set_id = azurerm_orchestrated_virtual_machine_scale_set.vmss.id
  custom_data                  = base64encode(data.template_file.linux-vm-cloud-init.rendered)
  depends_on = [module.vnet]
}

resource "azurerm_network_interface_security_group_association" "vmss" {
  network_interface_id      = module.linux_server.network_interface_id
  network_security_group_id = module.vnet.network_security_group_id
}

resource "tls_private_key" "ssh_serser" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

resource "local_file" "ssh_private_key_server" {
  filename = "./artifacts/ssh-key/d1-base-server-key.pem"
  content  = tls_private_key.ssh_serser.private_key_pem
}
