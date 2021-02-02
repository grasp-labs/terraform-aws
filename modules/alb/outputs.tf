output "alb_name" {
  description = "The ARN suffix of the ALB"
  value       = aws_alb.alb.name
}

output "http_target_group_arn" {
  description = "The ARN of the http target group."
  #value = join("", aws_alb_target_group.http.*.arn)
  value = aws_alb_target_group.http[0].arn
}
