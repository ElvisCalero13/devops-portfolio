variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "athena_results_bucket_name" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
