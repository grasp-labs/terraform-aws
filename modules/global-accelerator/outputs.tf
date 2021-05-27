output "ips" {
  description = "Static ips allocated"
  value = aws_globalaccelerator_accelerator.this.ip_sets
}

output "id" {
  description = "id of the global accelerator"
  value = aws_globalaccelerator_accelerator.this.id
}
