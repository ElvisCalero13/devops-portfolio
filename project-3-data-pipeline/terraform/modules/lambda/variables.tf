variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "lambda_role_arn" {
  type = string
}

variable "raw_bucket_name" {
  type = string
}

variable "processed_bucket_name" {
  type = string
}

variable "package_file" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "raw_bucket_arn" {
  type = string
}
