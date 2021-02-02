output "table_name" {
  value       = aws_dynamodb_table.default.name
  description = "DynamoDB table name"
}
