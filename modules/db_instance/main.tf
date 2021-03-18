data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  id_name = lower(regex("[a-z]+", var.rds_identifier))
}

resource "aws_db_subnet_group" "default" {
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "_" {
  vpc_id      = var.vpc_id
  description = "Allow inbound traffic from the security groups."
  tags        = var.tags
}

resource "aws_security_group_rule" "ingress_security_group" {
  description              = "Allow traffic from associate security group."
  from_port                = 5432
  protocol                 = "tcp"
  source_security_group_id = var.associate_security_group
  security_group_id        = aws_security_group._.id
  to_port                  = 5432
  type                     = "ingress"
}

resource "aws_security_group_rule" "http" {
  from_port         = 0
  protocol          = "tcp"
  cidr_blocks       = [
    "0.0.0.0/0"]
  to_port           = 0
  type              = "ingress"
  security_group_id = aws_security_group._.id
}

resource "aws_db_parameter_group" "pg" {
  name = "pg-${local.id_name})"
  family = "postgres12"
  description = "Parameter group for ${var.rds_identifier}"

  tags = var.tags
}

resource "aws_db_instance" "this" {
  identifier        = local.id_name
  engine            = "postgres"
  engine_version    = "12.4"
  allocated_storage = var.storage_size

  instance_class = var.instance_class
  name           = var.db_name
  username       = var.admin_user
  password       = var.admin_password

  parameter_group_name = aws_db_parameter_group.pg.name

  publicly_accessible = var.publicly_accessible
  skip_final_snapshot = true

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
