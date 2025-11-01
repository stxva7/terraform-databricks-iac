output "databricks_workspace_url" {
  description = "The URL of the created Databricks workspace"
  value       = azurerm_databricks_workspace.dbw.workspace_url
}
