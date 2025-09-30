terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "~> 2.40"
    }
  }
}

provider "confluent" {
  cloud_api_key      = var.confluent_cloud_api_key
  cloud_api_secret   = var.confluent_cloud_api_secret
  #flink_principal_id = var.flink_principal_id
}


# Fetch org id automatically
data "confluent_organization" "org" {}

resource "confluent_flink_statement" "stock_select" {
  organization { id = data.confluent_organization.org.id }
  environment  { id = var.environment_id }
  compute_pool { id = var.flink_compute_pool_id }

# ADDED THIS MISSING BLOCK
  principal {
    id = var.flink_principal_id
  }  

credentials {
    key    = var.flink_api_key
    secret = var.flink_api_secret
  }

  statement      = file("${path.module}/sql/stock_select.sql")
  statement_name = "stock-trades-sample-select"

  # Optional override for private endpoints
  rest_endpoint = var.flink_rest_endpoint

  properties = {
    "sql.current-catalog"  = "Rohit_env"
    "sql.current-database" = "demo_cluster_1"
  }

  lifecycle {
    create_before_destroy = true
  }
}
