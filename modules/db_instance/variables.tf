variable "vpc_id" {
  description = "The vpc id the database instance will be created."
  type        = string
}

variable "num_subnets" {
  description = "The number of subnets in current VPC."
  type        = number
  default     = 0
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

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
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