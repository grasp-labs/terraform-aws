resource "aws_security_group" "default" {
  name        = var.name
  vpc_id      = var.vpc_id
  description = var.description
  tags        = var.tags
  lifecycle {
    create_before_destroy = true
  }
}

#Module      : SECURITY GROUP RULE FOR INGRESS
#Description : Provides a security group rule resource. Represents a single ingress
#              group rule, which can be added to external Security Groups.
resource "aws_security_group_rule" "ingress" {
  count = length(compact(var.allowed_ports))

  type              = "ingress"
  from_port         = element(var.allowed_ports, count.index)
  to_port           = element(var.allowed_ports, count.index)
  protocol          = "tcp"
  cidr_blocks       = [
    "0.0.0.0/0"]
  security_group_id = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.default.*.id)
}
