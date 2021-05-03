output "bucket_id" {
    type        =string
    value       = aws_s3_bucket.default.id
    description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
    Type        = string
    value       = aws_s3_bucket.default.arn
    description = "Bucket ARN"
}