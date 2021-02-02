output "repository_url_map" {
  value = zipmap(
    values(aws_ecr_repository.name)[*].name,
    values(aws_ecr_repository.name)[*].repository_url
  )
  description = "Map of repository names to repository URLs"
}
