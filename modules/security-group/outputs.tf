output "security_group_id" {
  value       = aws_security_group.default.id
  description = "ID on the AWS Security Group associated with the instance."
}
