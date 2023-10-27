

variable "location" {
  type        = string
  description = "The location/region where the network security group is created. "
}

variable "inbound_rules" {
  type        = list(map(string))
  default     = []
  description = "List of objects that represent the configuration of each inbound rule."
  # inbound_rules = [
  #   {
  #     name                       = ""
  #     priority                   = ""
  #     access                     = ""
  #     protocol                   = ""
  #     source_address_prefix      = ""
  #     source_port_range          = ""
  #     destination_address_prefix = ""
  #     destination_port_range     = ""
  #     description                = ""
  #   }
  # ]
}

variable "outbound_rules" {
  type        = list(map(string))
  default     = []
  description = "List of objects that represent the configuration of each outbound rule."
  # outbound_rules = [
  #   {
  #     name                       = ""
  #     priority                   = ""
  #     access                     = ""
  #     protocol                   = ""
  #     source_address_prefix      = ""
  #     source_port_range          = ""
  #     destination_address_prefix = ""
  #     destination_port_range     = ""
  #     description                = ""
  #   }
  # ]
}

