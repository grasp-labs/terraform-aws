locals {
  base_name = "${var.project}-${var.stage}"
}

resource "aws_alb_target_group" "http" {
  count       = var.http_enabled ? 1 :0
  name        = substr("tg-http-${local.base_name}", 0 , 32)
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  depends_on  = [
    aws_alb.this]

  health_check {
    path     = var.health_check_path
    protocol = "HTTP"
    matcher  = "200-499"
  }

  tags = var.tags
}

resource "aws_alb_target_group" "https" {
  count       = var.https_enabled ? 1 :0
  name        = substr("tg-https-${local.base_name}", 0, 32)
  port        = 443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id
  depends_on  = [
    aws_alb.this]
  health_check {
    path     = var.health_check_path
    protocol = "HTTPS"
    matcher  = "200-499"
  }
  lifecycle {
    create_before_destroy = true
  }
  tags        = var.tags
}

resource "aws_alb" "this" {
  name            = "alb-${local.base_name}"
  security_groups = var.security_group_ids
  subnets         = var.subnet_ids

  tags = var.tags
}

resource "aws_alb_listener" "http_listener" {
  count             = var.http_enabled ? 1 : 0
  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.http[0].arn
  }
}

resource "aws_alb_listener" "https_listener" {
  count             = var.https_enabled ? 1 : 0
  load_balancer_arn = aws_alb.this.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.https[0].arn
  }
}

