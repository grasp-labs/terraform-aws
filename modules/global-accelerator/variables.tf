variable "project" {
  description = "The name of the project"
  type = string
}

variable "stage" {
  description = "Stage of the project"
  type = string
  default = "dev"
}

variable "http_enabled" {
  description = "Enable http"
  type = bool
  default = true
}

variable "https_enabled" {
  description = "Enable https"
  type = bool
  default = false
}

variable "alb_id" {
  description = "ID of Alb connected with the global accelerator"
  type = string
}

variable "health_check_path" {
  description = "Health check path"
  type = string
}