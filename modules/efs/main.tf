resource "aws_efs_file_system" "efs" {
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags             = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

resource "aws_security_group_rule" "ingress_security_groups" {
  count                    = length(var.ingress_security_groups)
  description              = "Allow inbound traffic from existing security groups"
  type                     = "ingress"
  from_port                = "2049"
  # NFS
  to_port                  = "2049"
  protocol                 = "tcp"
  source_security_group_id = var.ingress_security_groups[count.index]
  security_group_id        = join("", aws_security_group.efs.*.id)
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [
    "0.0.0.0/0"]
  security_group_id = aws_security_group.efs.id
}

resource "aws_security_group" "efs" {
  name        = "sg_efs_${var.name}"
  description = "EFS Security Group for ${var.name}"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "sg-efs-${var.name}"
  }
}

resource "aws_efs_mount_target" "default" {
  count           = length(var.subnets)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnets[count.index]
  security_groups = aws_security_group.efs.*.id

}

resource "aws_efs_access_point" "default" {
  count = length(var.access_points)

  file_system_id = aws_efs_file_system.efs.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = var.access_points[count.index]
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "777"
    }
  }

  tags = merge(
    var.tags,
    {
      Name: var.access_points[count.index]
    }
  )
}