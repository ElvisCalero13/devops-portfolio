output "raw_bucket_name" {
  value = module.s3.raw_bucket_name
}

output "processed_bucket_name" {
  value = module.s3.processed_bucket_name
}

output "athena_results_bucket_name" {
  value = module.s3.athena_results_bucket_name
}

output "lambda_function_name" {
  value = module.lambda.lambda_function_name
}

output "lambda_function_arn" {
  value = module.lambda.lambda_function_arn
}

output "glue_database_name" {
  value = module.glue.database_name
}

output "glue_table_name" {
  value = module.glue.table_name
}

output "athena_workgroup_name" {
  value = module.athena.workgroup_name
}

output "sns_topic_name" {
  value = module.sns.topic_name
}

output "sns_topic_arn" {
  value = module.sns.topic_arn
}

output "dashboard_name" {
  value = module.monitoring.dashboard_name
}
