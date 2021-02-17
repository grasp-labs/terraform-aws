variable "vpc_id" {
  description = "The vpc id the database instance will be created."
  type        = string
}

variable "rds_identifier" {
  description = "The name of the RDS instance."
  type        = string
}

variable "storage_size" {
  description = "Allocated storage size for database instance."
  type = number
  default = 5
}

variable "db_name" {
  description = "The name of the database."
  type        = string
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "admin_user" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = ""
}

variable "admin_password" {
  description = "Username for the master DB user"
  type        = string
}

variable "associate_security_group" {
  description = "Associated security groups to associate in the same VPC."
  type        = string
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}