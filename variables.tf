variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group."
  default     = "rg-provisioning-dev"
}

variable "location" {
  type        = string
  description = "Azure region for resource placement."
  default     = "eastus"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storage account (must be 3-24 characters, lowercase alphanumeric)."
  default     = "stprovdev01"
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account (Standard or Premium)."
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)."
  default     = "LRS"
}
