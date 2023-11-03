resource "azurerm_orchestrated_virtual_machine_scale_set" "vmss" {
  location                    = "japaneast"
  name                        = "vmssflex"
  platform_fault_domain_count = 1
  resource_group_name         = "d1-base-RG"
  zones                         = ["2","3"]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

module "linux_server" {
  source = "../../modules/terraform-azure-bastion"

  location                   = "japaneast"
  image_os                   = "linux"
  resource_group_name        = "d1-base-RG"
  allow_extension_operations = false
  boot_diagnostics           = false
  new_network_interface = {
    ip_forwarding_enabled = false
    ip_configurations = [
      {
        primary = true
      }
    ]
  }
  admin_username = "azureuser"
  admin_ssh_keys = [
    {
      public_key = tls_private_key.ssh_serser.public_key_openssh
    }
  ]
  name = "d1-base-server"
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  zone                         = "2"
  os_simple                    = "UbuntuServer"
  size                         = "Standard_DS1_v2"
  subnet_id                    = "/subscriptions/bdd42ea9-4917-426b-8e78-3a03b444f8e2/resourceGroups/d1-base-RG/providers/Microsoft.Network/virtualNetworks/d1-base-vnet/subnets/d1-base-server-subnet"
  virtual_machine_scale_set_id = azurerm_orchestrated_virtual_machine_scale_set.vmss.id
}

resource "azurerm_network_interface_security_group_association" "vmss" {
  network_interface_id      = module.linux_server.network_interface_id
  network_security_group_id = "/subscriptions/bdd42ea9-4917-426b-8e78-3a03b444f8e2/resourceGroups/d1-base-RG/providers/Microsoft.Network/networkSecurityGroups/d1-base-nsg"
}

resource "tls_private_key" "ssh_serser" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "ssh_private_key_server" {
  filename = "./ssh-key/d1-base-server-key.pem"
  content  = tls_private_key.ssh_serser.private_key_pem
}