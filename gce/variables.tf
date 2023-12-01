variable "project_id" {
  type        = string
  default     = "encoded-road-401507"
  description = "Project id of this compute instance"
}

variable "zone" {
  type        = string
  default     = "asia-southeast1-a"
  description = "Zone of this compute instance"
}

variable "device_name" {
  type        = string
  default     = "duckduck-vm"
  description = "The name of our instance"
}

variable "size" {
  type        = number
  default     = 15
  description = "The size of the boot disk"
}

variable "machine_type" {
  type        = string
  default     = "e2-medium"
  description = "The machine type of the instance"
}

variable "email" {
  type    = string
  default = "duckduckadmin@encoded-road-401507.iam.gserviceaccount.com"
}
