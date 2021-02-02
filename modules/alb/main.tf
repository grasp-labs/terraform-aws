locals {
  base_name = "${var.project}-${var.stage}"
}
resource "aws_alb_target_group" "http" {
  count       = var.http_enabled ? 1 :0
  name        = "tg-${local.base_name}-http"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path     = var.health_check_path
    protocol = "HTTP"
    matcher  = "200"
  }

  tags = var.tags
}

resource "aws_alb" "alb" {
  name            = "alb-${local.base_name}"
  security_groups = var.security_group_ids
  subnets         = var.subnet_ids

  tags = var.tags
}

resource "aws_alb_listener" "http_listener" {
  count             = var.http_enabled ? 1 : 0
  load_balancer_arn = aws_alb.alb.arn
  port              = 8000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.http[0].arn
  }
}
