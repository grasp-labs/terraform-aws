resource "aws_globalaccelerator_accelerator" "this" {
  name = "ga-${var.project}-${var.stage}"
  ip_address_type = "IPV4"
  enabled = true
}

resource "aws_globalaccelerator_listener" "http" {
  count = var.http_enabled ? 1 :0
  accelerator_arn = aws_globalaccelerator_accelerator.this.id
  protocol = "TCP"
  client_affinity = "SOURCE_IP"

  port_range {
    from_port = 80
    to_port = 80
  }
}

resource "aws_globalaccelerator_listener" "https" {
  count = var.https_enabled ? 1 : 0
  accelerator_arn = aws_globalaccelerator_accelerator.this.id
  protocol = "TCP"
  client_affinity = "SOURCE_IP"

  port_range {
    from_port = 443
    to_port = 443
  }
}

resource "aws_globalaccelerator_endpoint_group" "http" {
  count = var.http_enabled ? 1 : 0
  listener_arn = aws_globalaccelerator_listener.http.id
  health_check_interval_seconds = 10
  health_check_path = var.health_check_path
  health_check_protocol = "HTTP"
  threshold_count = 2

  endpoint_configuration {
    endpoint_id = var.alb_id
    weight = 100
  }
}

resource "aws_globalaccelerator_endpoint_group" "https" {
  listener_arn = aws_globalaccelerator_listener.https.id
  health_check_interval_seconds = 10
  health_check_path = var.health_check_path
  health_check_protocol = "HTTPS"
  threshold_count = 2

  endpoint_configuration {
    endpoint_id = var.alb_id
    weight = 100
  }
}
