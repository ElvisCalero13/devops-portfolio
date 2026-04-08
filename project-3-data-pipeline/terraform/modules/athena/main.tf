locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "aws_athena_workgroup" "this" {
  name = "${local.name_prefix}-wg"

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${var.athena_results_bucket_name}/results/"
    }
  }

  tags = merge(var.common_tags, {
    Name = "${local.name_prefix}-wg"
  })
}
