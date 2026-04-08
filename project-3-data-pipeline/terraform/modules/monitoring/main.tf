locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "${local.name_prefix}-lambda-errors"
  alarm_description   = "Lambda function has errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 0
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"

  alarm_actions = [var.sns_topic_arn]
  ok_actions    = [var.sns_topic_arn]

  dimensions = {
    FunctionName = var.lambda_function_name
  }

  tags = var.common_tags
}

resource "aws_cloudwatch_metric_alarm" "lambda_duration_high" {
  alarm_name          = "${local.name_prefix}-lambda-duration-high"
  alarm_description   = "Lambda duration is too high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 10000
  metric_name         = "Duration"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Average"
  treat_missing_data  = "notBreaching"

  alarm_actions = [var.sns_topic_arn]
  ok_actions    = [var.sns_topic_arn]

  dimensions = {
    FunctionName = var.lambda_function_name
  }

  tags = var.common_tags
}

resource "aws_cloudwatch_metric_alarm" "lambda_throttles" {
  alarm_name          = "${local.name_prefix}-lambda-throttles"
  alarm_description   = "Lambda is being throttled"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 0
  metric_name         = "Throttles"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"

  alarm_actions = [var.sns_topic_arn]
  ok_actions    = [var.sns_topic_arn]

  dimensions = {
    FunctionName = var.lambda_function_name
  }

  tags = var.common_tags
}

resource "aws_cloudwatch_dashboard" "project_3" {
  dashboard_name = "${local.name_prefix}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title   = "Lambda Invocations"
          region  = "ap-southeast-2"
          view    = "timeSeries"
          stacked = false
          metrics = [
            [
              "AWS/Lambda",
              "Invocations",
              "FunctionName",
              var.lambda_function_name
            ]
          ]
          stat   = "Sum"
          period = 300
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title   = "Lambda Errors"
          region  = "ap-southeast-2"
          view    = "timeSeries"
          stacked = false
          metrics = [
            [
              "AWS/Lambda",
              "Errors",
              "FunctionName",
              var.lambda_function_name
            ]
          ]
          stat   = "Sum"
          period = 300
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title   = "Lambda Duration"
          region  = "ap-southeast-2"
          view    = "timeSeries"
          stacked = false
          metrics = [
            [
              "AWS/Lambda",
              "Duration",
              "FunctionName",
              var.lambda_function_name
            ]
          ]
          stat   = "Average"
          period = 300
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          title   = "Lambda Throttles"
          region  = "ap-southeast-2"
          view    = "timeSeries"
          stacked = false
          metrics = [
            [
              "AWS/Lambda",
              "Throttles",
              "FunctionName",
              var.lambda_function_name
            ]
          ]
          stat   = "Sum"
          period = 300
        }
      }
    ]
  })
}
