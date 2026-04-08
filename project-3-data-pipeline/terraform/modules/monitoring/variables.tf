variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "lambda_function_name" {
  type = string
}

variable "sns_topic_arn" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
