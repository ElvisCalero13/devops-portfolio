locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "aws_lambda_function" "processor" {
  function_name = "${local.name_prefix}-processor"
  role          = var.lambda_role_arn
  handler       = "processor.handler"
  runtime       = "python3.11"

  filename         = var.package_file
  source_code_hash = filebase64sha256(var.package_file)

  timeout     = 30
  memory_size = 256

  environment {
    variables = {
      RAW_BUCKET       = var.raw_bucket_name
      PROCESSED_BUCKET = var.processed_bucket_name
    }
  }

  tags = merge(var.common_tags, {
    Name = "${local.name_prefix}-processor"
  })
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.processor.function_name}"
  retention_in_days = 7

  tags = merge(var.common_tags, {
    Name = "${local.name_prefix}-lambda-log-group"
  })
}

resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.processor.function_name
  principal     = "s3.amazonaws.com"

  source_arn = var.raw_bucket_arn
}

resource "aws_s3_bucket_notification" "raw_trigger" {
  bucket = var.raw_bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.processor.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3_invoke]
}
