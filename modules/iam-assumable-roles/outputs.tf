output "iam_role_arn" {
  description = "ARN of admin IAM role"
  value       = aws_iam_role.this.arn
}
