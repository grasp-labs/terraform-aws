output "alb_name" {
  description = "The ARN suffix of the ALB"
  value       = aws_alb.this.name
}

output "http_target_group_arn" {
  description = "The ARN of the http target group."
  value = aws_alb_target_group.http[0].arn
}

output "https_target_group_arn" {
  description = "The ARN of the https target group."
  value = aws_alb_target_group.https[0].arn
}
