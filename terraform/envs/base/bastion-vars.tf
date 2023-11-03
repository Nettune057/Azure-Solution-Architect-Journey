variable "algorithm" {
  default = "RSA"
}

variable "rsa_bits" {
  default = 2048
}

variable "filename" {
}

variable "public_ssh_key" {
  description = "An ssh key set in the main variables of the terraform-azurerm-aks module"
  default     = ""
}

variable "image_os" {
  default = "linux"
}

variable "allow_extention_operations" {
  default = false
}

variable "ip_forwarding_enabled" {
  default = false
}

variable "admin_username_bastion" {
  default = "bastion-user"
}

variable "bastion_vm_name" {
  default = "bastion"
}

variable "caching" {
  default = "ReadWrite"
}

variable "storage_account_os_type" {
  default = "Standard_LRS"
}

variable "os_simple" {
  default = "UbuntuServer"
}

variable "size" {
  default = "Standard_DS1_v2"
}

variable "zone" {
  default = "2"
}