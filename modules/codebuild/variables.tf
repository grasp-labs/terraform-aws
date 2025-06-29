variable name  {
  type        = string
  description = "Name of the CodeBuild project"
}

variable "description" {
  type        = string
  default     = "CodeBuild project for the ds-client"
  description = "Description of the CodeBuild project"
}

variable "source_repo_url" {
  type        = string
  description = "URL of the source repository for the CodeBuild project"
}

variable "source_repo_branch" {
  type        = string
  default     = "main"
  description = "Branch of the source repository for the CodeBuild project"
}

variable "connection_name" {
  type        = string
  description = "Name of the CodeBuild connection to the source repository"
}

variable "artifact_bucket" {
  type        = string
  default     = "ds-client-artifacts"
  description = "S3 bucket for storing build artifacts"
}

variable "artifact_path" {
  type        = string
  description = "Path within the S3 bucket where build artifacts will be stored"
}

variable "buildspec_path" {
  type        = string
  default     = "buildspec.yml"
  description = "Path to the buildspec file in the source repository"
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "Environment variables to pass to the CodeBuild project"
}

variable "package_type" {
  type        = string
  default     = "ZIP"
  description = "Type of build output artifact to create. If type is set to S3, valid values are NONE, ZIP"
}
