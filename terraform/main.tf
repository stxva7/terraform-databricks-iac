###############################################
# Terraform - Azure Databricks (Workspace + Cluster)
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

  backend "azurerm" {
    resource_group_name   = "rg-databricks-iac"
    storage_account_name  = "tfstate4807"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}

###############################################
# PROVIDERS
###############################################
provider "azurerm" {
  features {}
}

# Azure Active Directory (AAD) authenticated Databricks provider
provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.dbw.id
}

###############################################
# RESOURCE GROUP
###############################################
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

###############################################
# DATABRICKS WORKSPACE
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
# DATABRICKS CLUSTER (Basic Compute Node)
###############################################
resource "databricks_cluster" "dev_cluster" {
  cluster_name            = var.cluster_name
  spark_version           = var.spark_version
  node_type_id            = var.node_type
  autotermination_minutes = var.autotermination_minutes
  num_workers             = 0  

  spark_conf = {
    "spark.databricks.cluster.profile" = "singleNode"  
    "spark.master"                     = "local[*]"    
  }

  custom_tags = {
    "ResourceClass" = "SingleNode"
    "Environment"   = "Dev"
  }

  depends_on = [azurerm_databricks_workspace.dbw]
}

