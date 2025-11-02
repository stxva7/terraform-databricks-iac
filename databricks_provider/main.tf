terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.34.0"
    }
  }

  required_version = ">= 1.5.0"

  backend "local" {}
}

provider "databricks" {
  host  = var.databricks_host
  token = var.databricks_token
}

#This is a read-only test resource to confirm the connection
data "databricks_current_user" "me" {}

output "databricks_current_user" {
  value = data.databricks_current_user.me.user_name
}
