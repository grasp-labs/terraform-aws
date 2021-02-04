data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  security_group_name = "sg-${var.rds_identifier}"
  subnet_group_name = "subnet-group-${var.rds_identifier}"
}

resource "aws_subnet" "_" {
  count                   = length(data.aws_availability_zones.available.names)
  cidr_block              = "172.30.${var.num_subnets + count.index}.0/24"
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = false
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
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
  security_group_id = var.associate_security_group
  to_port           = 5432
  type              = "ingress"
}

resource "aws_db_subnet_group" "_" {
  name        = local.subnet_group_name
  description = "RDS subnet group for ${var.rds_identifier}."
  subnet_ids  = aws_subnet._.*.id
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
  db_subnet_group_name   = aws_db_subnet_group._.name

  tags = merge(
  var.tags,
  {
    "Name" = format("%s", var.rds_identifier)
  },
  )
}