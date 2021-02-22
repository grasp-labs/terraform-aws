output "lambda_arn" {
  description = "ARN for the Lambda function"
  value       = aws_lambda_function.main.arn
}

output "invoke_arn" {
  description = "ARN used to invoke Lambda function from API Gateway"
  value       = aws_lambda_function.main.invoke_arn
}