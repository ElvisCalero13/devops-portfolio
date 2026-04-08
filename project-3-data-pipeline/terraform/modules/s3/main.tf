locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "aws_s3_bucket" "raw" {
  bucket = "${local.name_prefix}-raw"

  tags = merge(var.common_tags, {
    Name = "${local.name_prefix}-raw"
    Zone = "raw"
  })
}

resource "aws_s3_bucket" "processed" {
  bucket = "${local.name_prefix}-processed"

  tags = merge(var.common_tags, {
    Name = "${local.name_prefix}-processed"
    Zone = "processed"
  })
}

resource "aws_s3_bucket" "athena_results" {
  bucket = "${local.name_prefix}-athena-results"

  tags = merge(var.common_tags, {
    Name = "${local.name_prefix}-athena-results"
    Zone = "athena-results"
  })
}

resource "aws_s3_bucket_versioning" "raw" {
  bucket = aws_s3_bucket.raw.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "processed" {
  bucket = aws_s3_bucket.processed.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "athena_results" {
  bucket = aws_s3_bucket.athena_results.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "raw" {
  bucket = aws_s3_bucket.raw.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "processed" {
  bucket = aws_s3_bucket.processed.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "athena_results" {
  bucket = aws_s3_bucket.athena_results.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
