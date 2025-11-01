terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  required_version = ">= 1.5.0"

  backend "local" {}
}

provider "azurerm" {
  features {}
}

#Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

#Create the Databricks workspace
resource "azurerm_databricks_workspace" "dbw" {
  name                = var.workspace_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.workspace_sku

  tags = {
    environment = "dev"
    project     = "databricks-iac"
  }
}
