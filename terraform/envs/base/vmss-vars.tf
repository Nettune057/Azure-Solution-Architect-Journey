variable "vmss_name"{
  default = "vmss"
}

variable "platform_fault_domain_count" {
  default = 1
}

variable "vmss_zone" {
  default = ["2","3"]
}

variable "admin_username_server" {
  default = "server"
}

variable "boot_diagnostic_vmss" {
  default = false
}

variable "vmss_vm_name" {
  default = "vmss-server"
}

variable "vmss_vm_zone" {
  default = "2"
}