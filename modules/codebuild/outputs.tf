output "codebuild_project_name" {
  value = aws_codebuild_project.this.name
}

output "artifact" {
  value = aws_codebuild_project.this.artifacts[0].location
}