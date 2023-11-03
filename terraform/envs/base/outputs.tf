output "bastion_subnet_id" {
  value = module.vnet.bastion_subnet
}

output "bastion_pip" {
  value = module.vnet.bastion_pip
}

output "nsg_id" {
  value = module.vnet.network_security_group_id
}