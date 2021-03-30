data "template_file" "cloudformation_sns_stack" {
    template = file("${path.module}/templates/email_sns_stack.json.tpl")

    vars = {
        display_name: var.display_name
        subscriptions = join(
      ",",
      formatlist(
        "{ \"Endpoint\": \"%s\", \"Protocol\": \"email\"  }",
        var.emails
      ),
    )
  }
}

resource "aws_cloudformation_stack" "sns_topic" {
    name = var.stack_name
    template_body = data.template_file.cloudformation_sns_stack.rendered

    tags = merge(
        {
            Name = var.stack_name
        }
    )
}