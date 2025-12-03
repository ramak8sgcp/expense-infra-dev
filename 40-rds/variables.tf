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

variable "rds_tags" {
  default = {
    Component = "mysql"
  }
}

variable "zone_name" {
  default = "ramana3490.online"
}

variable "zone_id" {
  type        = string
  default = "Z00280343M1NSFAEBLQAW"
  description = "Route53 Hosted Zone ID"
}

