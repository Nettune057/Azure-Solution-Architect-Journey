
variable "static_website_source_folder" {
  default = "artifacts/imagine"
}

variable "create_resource_group" {
  default = false
}

variable "storacc_sku" {
  default = "Standard_ZRS"
}

variable "account_kind" {
  default = "StorageV2"
}

variable "cdn_profile_name" {
  default = "cdn"
}

variable "enable_cdn_profile" {
  default = true
}
variable "cdn_sku_profile" {
  default = "Standard_Microsoft"
}

variable "index_path" {
  description = "path from your repo root to index.html"
  default     = "index.html"
}

variable "custom_404_path" {
  description = "path from your repo root to your custom 404 page"
  default     = "404.html"
}
