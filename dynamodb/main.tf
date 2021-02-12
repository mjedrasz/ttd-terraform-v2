resource "aws_dynamodb_table" "table" {
  name           = "${var.aws_env}-${var.table_name}"
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  range_key      = var.range_key

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  ttl {
    attribute_name = var.ttl_attribute_name
    enabled        = var.ttl_enabled
  }
  
  dynamic "global_secondary_index" {
    for_each = var.gsi
    content {
      name = global_secondary_index.value.name
      read_capacity = global_secondary_index.value.read_capacity
      write_capacity = global_secondary_index.value.write_capacity
      hash_key = global_secondary_index.value.hash_key
      range_key = global_secondary_index.value.range_key
      projection_type = global_secondary_index.value.projection_type
      non_key_attributes = global_secondary_index.value.non_key_attributes
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.lsi
    content {
      name = local_secondary_index.value.name
      range_key = local_secondary_index.value.range_key
      projection_type = local_secondary_index.value.projection_type
      non_key_attributes = local_secondary_index.value.non_key_attributes
    }
  }

  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type

  tags = var.default_tags
}

resource "aws_ssm_parameter" "stream_arn" {
  count = var.stream_enabled && var.override_dynamodb_endpoint == "" ? 1 : 0
  name  = "/${var.aws_env}/dynamodb/streams/${aws_dynamodb_table.table.name}"
  type  = "String"
  value = aws_dynamodb_table.table.stream_arn
}