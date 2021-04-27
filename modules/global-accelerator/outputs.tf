output "ips" {
  description = "Static ips allocated"
  value = aws_globalaccelerator_accelerator.this.ip_sets
}