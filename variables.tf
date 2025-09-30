# Provider creds (cloud-level) used by the Confluent Terraform provider
variable "confluent_cloud_api_key" {
  type        = string
  description = "Confluent Cloud API key (management/provider auth)"
}

variable "confluent_cloud_api_secret" {
  type        = string
  description = "Confluent Cloud API secret (management/provider auth)"
  sensitive   = true
}

# Where the compute pool lives / which environment
variable "environment_id" {
  type        = string
  description = "Confluent Environment ID (where the compute pool is)"
}

variable "flink_compute_pool_id" {
  type        = string
  description = "ID of the existing Flink compute pool (you can copy from the Console)"
}

# The Flink API key/secret you said you will create in Console under your account
variable "flink_api_key" {
  type        = string
  description = "Flink-region API key (generated from Console/CLI/API). This is distinct from cloud API key."
}

variable "flink_api_secret" {
  type        = string
  description = "Flink-region API secret (paired with the key)"
  sensitive   = true
}

# Flink Principal ID
variable "flink_principal_id" {
  type        = string
  description = "Flink Principal ID (service account ID tied to the Flink API key)"
}

# Optional: REST endpoint override (useful for private networking / proxy)
variable "flink_rest_endpoint" {
  type        = string
  description = "Optional: explicit Flink REST endpoint (e.g. https://flink.us-east-1.aws.confluent.cloud). Leave empty for default."
  default     = ""
}
