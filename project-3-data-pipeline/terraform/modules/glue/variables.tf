variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "processed_bucket_name" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
