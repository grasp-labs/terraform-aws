output "arn" {
  value       = aws_efs_file_system.efs.arn
  description = "EFS ARN"
}

output "access_point_arns" {
  value       = { for arn in sort(var.access_points) : arn => aws_efs_access_point.default[arn].arn }
  description = "EFS AP ARNs"
}

output "access_point_ids" {
  value       = { for id in sort(var.access_points) : id => aws_efs_access_point.default[id].id }
  description = "EFS AP ids"
}

output "mount_target_ids" {
  value       = coalescelist(aws_efs_mount_target.default.*.id, [""])
  description = "List of EFS mount target IDs (one per Availability Zone)"
}

output "security_group_id" {
  value       = aws_security_group.efs.id
  description = "EFS Security Group ID"
}