variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-databricks-iac"
}

variable "workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
  default     = "dbw-terraform-iac"
}

variable "location" {
  description = "Azure region for the workspace"
  type        = string
  default     = "Central India"
}

variable "workspace_sku" {
  description = "Databricks workspace SKU: standard or premium"
  type        = string
  default     = "standard"
}
