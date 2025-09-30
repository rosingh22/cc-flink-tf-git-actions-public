output "flink_statement_id" {
  description = "ID of the Flink SQL statement created"
  value       = confluent_flink_statement.stock_select.id
}
