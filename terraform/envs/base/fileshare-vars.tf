variable "fileshare_stoacc_name" {
  default = "fileshare"
}

variable "fileshare" {
  default = "fileshare"
}

variable "quota" {
  default = 250
}

variable "ip_rules" {
  default = ["27.72.98.245","221.133.18.67"]
}

variable "bypass" {
  default = ["None"]
}