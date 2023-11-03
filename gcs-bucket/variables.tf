variable "bucket_name" {
  type        = string
  default     = "duckduck-bucket"
  description = "The name of our bucket"
}

variable "bucket_location" {
  type    = string
  default = "ASIA-SOUTHEAST1"
}

variable "project_id" {
  type    = string
  default = "encoded-road-401507"
}

variable "storage_class" {
  type    = string
  default = "REGIONAL"
}
