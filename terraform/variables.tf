###############################################
# VARIABLES
###############################################

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  default     = "rg-databricks-iac"
}

variable "workspace_name" {
  description = "Name of the Databricks Workspace"
  default     = "dbw-terraform-iac"
}

variable "location" {
  description = "Azure region for the workspace"
  default     = "Central India"
}

variable "workspace_sku" {
  description = "Databricks workspace pricing tier"
  default     = "standard"
}
