resource "aws_ecr_repository" "name" {
  for_each = toset(var.image_names)
  name     = "${each.value}/${var.stage}"

  tags = var.tags
}
