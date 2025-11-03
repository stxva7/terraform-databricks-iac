###############################################
# OUTPUTS
###############################################

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "databricks_workspace_url" {
  description = "Databricks workspace URL after creation"
  value       = azurerm_databricks_workspace.dbw.workspace_url
}
