output "arn" {
  value       = aws_efs_file_system.efs.arn
  description = "EFS ARN"
}

output "access_point_arns" {
  value       = aws_efs_access_point.default.*.arn
  description = "EFS AP ARNs"
}

output "access_point_ids" {
  value       = aws_efs_access_point.default.*.id
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