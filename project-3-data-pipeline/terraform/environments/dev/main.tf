locals {
  project_name = "project-3-data-pipeline"
  environment  = "dev"

  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    ManagedBy   = "Terraform"
  }
}

module "s3" {
  source = "../../modules/s3"

  project_name = local.project_name
  environment  = local.environment
  common_tags  = local.common_tags
}

module "iam" {
  source = "../../modules/iam"

  project_name         = local.project_name
  environment          = local.environment
  raw_bucket_arn       = module.s3.raw_bucket_arn
  processed_bucket_arn = module.s3.processed_bucket_arn
  common_tags          = local.common_tags
}

module "lambda" {
  source = "../../modules/lambda"

  project_name          = local.project_name
  environment           = local.environment
  lambda_role_arn       = module.iam.lambda_role_arn
  raw_bucket_name       = module.s3.raw_bucket_name
  raw_bucket_arn        = module.s3.raw_bucket_arn
  processed_bucket_name = module.s3.processed_bucket_name
  source_file           = abspath("${path.root}/../../../lambda/processor.py")
  common_tags           = local.common_tags
}

module "glue" {
  source = "../../modules/glue"

  project_name          = local.project_name
  environment           = local.environment
  processed_bucket_name = module.s3.processed_bucket_name
  common_tags           = local.common_tags
}

module "athena" {
  source = "../../modules/athena"

  project_name               = local.project_name
  environment                = local.environment
  athena_results_bucket_name = module.s3.athena_results_bucket_name
  common_tags                = local.common_tags
}

module "sns" {
  source = "../../modules/sns"

  project_name = local.project_name
  environment  = local.environment
  alert_email  = var.alert_email
  common_tags  = local.common_tags
}

module "monitoring" {
  source = "../../modules/monitoring"

  project_name         = local.project_name
  environment          = local.environment
  lambda_function_name = module.lambda.lambda_function_name
  sns_topic_arn        = module.sns.topic_arn
  common_tags          = local.common_tags
}
