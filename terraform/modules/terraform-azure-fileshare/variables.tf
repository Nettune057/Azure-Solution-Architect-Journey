
variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  type        = string
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the azure storage account"
  default     = "kaopizd1test"
  type        = string
}

variable "account_kind" {
  description = "The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  default     = "FileStorage"
  type        = string
}

variable "skuname" {
  description = "The SKUs supported by Microsoft Azure Storage. Valid options are Premium_LRS, Premium_ZRS, Standard_GRS, Standard_GZRS, Standard_LRS, Standard_RAGRS, Standard_RAGZRS, Standard_ZRS"
  default     = "Premium_ZRS"
  type        = string
}



variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account"
  default     = "TLS1_2"
  type        = string
}


variable "container_soft_delete_retention_days" {
  description = "Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`"
  default     = 7
  type        = number
}

variable "enable_versioning" {
  description = "Is versioning enabled? Default to `false`"
  default     = false
  type        = bool
}

variable "last_access_time_enabled" {
  description = "Is the last access time based tracking enabled? Default to `false`"
  default     = false
  type        = bool
}

variable "change_feed_enabled" {
  description = "Is the blob service properties for change feed events enabled?"
  default     = false
  type        = bool
}

variable "enable_advanced_threat_protection" {
  description = "Boolean flag which controls if advanced threat protection is enabled."
  default     = false
  type        = bool
}

variable "network_rules" {
  description = "Network rules restricing access to the storage account."
  type        = object({ bypass = list(string), ip_rules = list(string), subnet_ids = list(string) })
  default     = null
}

variable "file_shares" {
  description = "List of containers to create and their access levels."
  type        = list(object({ name = string, quota = number }))
  default     = []
}

variable "lifecycles" {
  description = "Configure Azure Storage firewalls and virtual networks"
  type        = list(object({ prefix_match = set(string), tier_to_cool_after_days = number, tier_to_archive_after_days = number, delete_after_days = number, snapshot_delete_after_days = number }))
  default     = []
}

variable "managed_identity_type" {
  description = "The type of Managed Identity which should be assigned to the Linux Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned`"
  default     = null
  type        = string
}

variable "managed_identity_ids" {
  description = "A list of User Managed Identity ID's which should be assigned to the Linux Virtual Machine."
  default     = null
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
