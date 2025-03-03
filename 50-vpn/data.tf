data "aws_ssm_parameter" "vpc_sg_id" {
  name = "/${var.project_name}/${var.environment}/vpc_sg_id"
}

data "aws_ssm_parameter" "public_subnet_id" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}


data "aws_ami" "joindevops" {

  most_recent = true
  owners      = ["679593333241"] #need to update  ami owner after connectied with vpn

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-fe8020db-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}