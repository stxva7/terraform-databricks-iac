###############################################
# Terraform - Azure Databricks Workspace Setup
# (Minimal: Resource Group + Databricks Workspace)
# Databricks provider uses AAD auth via azure_workspace_resource_id
###############################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.117.1"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.34.0"
    }
  }

  backend "local" {}
}

###############################################
# PROVIDER - AZURE
###############################################
provider "azurerm" {
  features {}
}

###############################################
# RESOURCE GROUP
###############################################
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    project = "terraform-databricks-iac"
  }
}

###############################################
# DATABRICKS WORKSPACE (minimal)
###############################################
resource "azurerm_databricks_workspace" "dbw" {
  name                = var.workspace_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.workspace_sku

  tags = {
    Environment = "Dev"
    Project     = "Terraform-Databricks-IaC"
  }
}

###############################################
# DATABRICKS PROVIDER (AAD)
# The provider will authenticate using Azure CLI or a Service Principal (CI).
# It binds to the workspace using the workspace resource id below.
###############################################
provider "databricks" {
  # Bind provider to the exact workspace we created above.
  azure_workspace_resource_id = azurerm_databricks_workspace.dbw.id
}

###############################################
# (Optional) Example cluster - keep commented until you want to create clusters
###############################################
# resource "databricks_cluster" "demo_cluster" {
#   cluster_name            = "TF-DAB-CLUSTER"
#   spark_version           = "13.3.x-scala2.12"
#   node_type_id            = "Standard_F4s_v2"
#   num_workers             = 0
#   autotermination_minutes = 15
#   custom_tags = {
#     Environment = "Dev"
#   }
# }

###############################################
# OUTPUTS
###############################################
/* output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "databricks_workspace_url" {
  description = "Databricks workspace URL after creation"
  value       = azurerm_databricks_workspace.dbw.workspace_url
} */
