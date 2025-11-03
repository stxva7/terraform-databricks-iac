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
  default     = "centralindia"
}

variable "workspace_sku" {
  description = "Databricks workspace pricing tier"
  default     = "standard"
}

variable "cluster_name" {
  description = "Databricks cluster name"
  default     = "TF-DEV-CLUSTER"
}

variable "spark_version" {
  description = "Databricks runtime version"
  default     = "13.3.x-scala2.12"
}

variable "node_type" {
  description = "Node type for the cluster"
  default     = "Standard_DS2_v2"
}

variable "num_workers" {
  description = "Number of workers in the cluster"
  default     = 1
}

variable "autotermination_minutes" {
  description = "Auto-terminate idle cluster (minutes)"
  default     = 15
}
