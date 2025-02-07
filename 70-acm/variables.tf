variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project     = "expense"
    Terraform   = "true"
    Environment = "dev"
  }
}


variable "zone_name" {
  default = "ramana3490.online"
}

variable "zone_id" {
  default = "Z07026951IZYV04HDC3NF"
}