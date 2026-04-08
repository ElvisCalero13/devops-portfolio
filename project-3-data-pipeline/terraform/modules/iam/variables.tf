variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "raw_bucket_arn" {
  type = string
}

variable "processed_bucket_arn" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
