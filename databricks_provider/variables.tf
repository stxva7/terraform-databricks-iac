variable "databricks_host" {
  description = "Databricks workspace URL"
  type        = string
}

variable "databricks_token" {
  description = "Databricks Personal Access Token (PAT)"
  type        = string
  sensitive   = true
}
