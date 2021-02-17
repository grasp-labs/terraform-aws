data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  security_group_name = "sg-${var.rds_identifier}"
  subnet_group_name = "subnet-group-${var.rds_identifier}"
}

resource "aws_db_subnet_group" "default" {
  name       = local.subnet_group_name
  subnet_ids = var.subnet_ids
  tags = var.tags
}

resource "aws_security_group" "_" {
  vpc_id      = var.vpc_id
  description = "Allow inbound traffic from the security groups."
  name        = local.security_group_name
  tags        = var.tags
}

resource "aws_security_group_rule" "ingress_security_group" {
  description = "Allow traffic from associate security group."
  from_port         = 5432
  protocol          = "tcp"
  source_security_group_id = var.associate_security_group
  security_group_id = aws_security_group._.id
  to_port           = 5432
  type              = "ingress"
}

resource "aws_db_instance" "this" {
  identifier        = var.rds_identifier
  engine            = "postgres"
  engine_version    = "12.4"
  allocated_storage = var.storage_size

  instance_class = var.instance_class
  name           = var.db_name
  username       = var.admin_user
  password       = var.admin_password

  vpc_security_group_ids = [
    aws_security_group._.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name

  tags = merge(
  var.tags,
  {
    "Name" = format("%s", var.rds_identifier)
  },
  )
}