output "instance_address" {
  value       = aws_db_instance.this.address
  description = "Address of the instance"
}

output "instance_arn" {
  value       = aws_db_instance.this.arn
  description = "ARN of the instance"
}