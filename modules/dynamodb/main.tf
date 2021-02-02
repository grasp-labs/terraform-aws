locals {
  name = "${var.project}-${var.stage}-${var.name}"
  attributes = concat(
  [
    {
      name = var.range_key
      type = var.range_key_type
    },
    {
      name = var.hash_key
      type = var.hash_key_type
    }
  ]
  )

  # Remove the first map from the list if no `range_key` is provided
  from_index = length(var.range_key) > 0 ? 0 : 1

  attributes_final = slice(local.attributes, local.from_index, length(local.attributes))
}

resource "aws_dynamodb_table" "default" {
  name             = local.name
  billing_mode     = "PROVISIONED"
  read_capacity    = 20
  write_capacity   = 20
  hash_key         = var.hash_key
  range_key        = var.range_key

  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity
    ]
  }

  dynamic "attribute" {
    for_each = local.attributes_final
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }
}
