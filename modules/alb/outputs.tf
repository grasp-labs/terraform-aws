output "alb_name" {
  description = "The ARN suffix of the ALB"
  value       = aws_alb.this.name
}

output "id" {
  description = "Id of the ALB"
  value       = aws_alb.this.id
}

output "http_target_group_arn" {
  description = "The ARN of the http target group."
  value       = length(aws_alb_target_group.http) > 0 ? aws_alb_target_group.http[0].arn : null
}

output "https_target_group_arn" {
  description = "The ARN of the https target group."
  value       = length(aws_alb_target_group.https) > 0 ? aws_alb_target_group.https[0].arn : null
}
