data "aws_ssm_parameter" "vpc_id" {
  #/expense/dev/mysql_sg_id
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "app_alb_sg_id" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

# data "aws_ssm_parameter" "public_subnet_ids" {
#   #/expense/dev/public_subnet_ids
#   name = "/${var.project_name}/${var.environment}/public_subnet_ids"
# }