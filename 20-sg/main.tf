module "mysql_sg" {
  source       = "git::https://github.com/ramak8sgcp/terraform-aws-security-group.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "mysql"
  vpc_ip       = local.vpc_id
  common_tags  = var.common_tags
  sg_tags      = var.mysql_sg_tag
}

module "backend_sg" {
  source       = "git::https://github.com/ramak8sgcp/terraform-aws-security-group.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "backend"
  vpc_ip       = local.vpc_id
  common_tags  = var.common_tags
  sg_tags      = var.backend_sg_tag
}

module "frontend_sg" {
  source       = "git::https://github.com/ramak8sgcp/terraform-aws-security-group.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "frontend"
  vpc_ip       = local.vpc_id
  common_tags  = var.common_tags
  sg_tags      = var.frontend_sg_tag
}

module "bastion_sg" {
  source       = "git::https://github.com/ramak8sgcp/terraform-aws-security-group.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "bastion"
  vpc_ip       = local.vpc_id
  common_tags  = var.common_tags
  sg_tags      = var.bastion_sg_tag
}

module "ansible_sg" {
  source       = "git::https://github.com/ramak8sgcp/terraform-aws-security-group.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "ansible"
  vpc_ip       = local.vpc_id
  common_tags  = var.common_tags
  sg_tags      = var.ansible_sg_tag
}


# module "app_alb_sg" {
#     source = "git::https://github.com/ramak8sgcp/terraform-aws-security-group.git?ref=main"
#     project_name = var.project_name
#     environment = var.environment
#     sg_name = "app_alb"
#     vpc_ip = local.vpc_id
#     common_tags = var.common_tags
#     sg_tags = var.app_alb_sg_tag
# }

# module "web_alb_sg" {
#     source = "git::https://github.com/ramak8sgcp/terraform-aws-security-group.git?ref=main"
#     project_name = var.project_name
#     environment = var.environment
#     sg_name = "web_alb" #expense-dev-app-alb
#     vpc_ip = local.vpc_id
#     common_tags = var.common_tags
#     sg_tags = var.web_alb_sg_tag
# }

# module "vpn_sg" {
#     source = "git::https://github.com/ramak8sgcp/terraform-aws-security-group.git?ref=main"
#     project_name = var.project_name
#     environment = var.environment
#     sg_name = "vpn"
#     vpc_ip = local.vpc_id
#     common_tags = var.common_tags
# }

# MySQL allowing connectin on 3306  from the instances attached to backend SG
resource "aws_security_group_rule" "mysql_backend" {
  type                     = "ingress"
  from_port                = "3306"
  to_port                  = "3306"
  protocol                 = "tcp"
  source_security_group_id = module.backend_sg.id
  security_group_id        = module.mysql_sg.id
}

resource "aws_security_group_rule" "backend_frontend" {
  type                     = "ingress"
  from_port                = "8080"
  to_port                  = "8080"
  protocol                 = "tcp"
  source_security_group_id = module.frontend_sg.id
  security_group_id        = module.backend_sg.id
}

resource "aws_security_group_rule" "frontend_public" {
  type              = "ingress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend_sg.id
}

resource "aws_security_group_rule" "mysql_bastion" {
  type                     = "ingress"
  from_port                = "3306"
  to_port                  = "3306"
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id        = module.mysql_sg.id
}

resource "aws_security_group_rule" "backend_bastion" {
  type                     = "ingress"
  from_port                = "8080"
  to_port                  = "8080"
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id        = module.backend_sg.id
}

resource "aws_security_group_rule" "frontend_bastion" {
  type                     = "ingress"
  from_port                = "80"
  to_port                  = "80"
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id        = module.fron_sg.id
}

resource "aws_security_group_rule" "mysql_ansible" {
  type                     = "ingress"
  from_port                = "22"
  to_port                  = "22"
  protocol                 = "tcp"
  source_security_group_id = module.ansible_sg.id
  security_group_id        = module.mysql_sg.id
}

resource "aws_security_group_rule" "backend_ansible" {
  type                     = "ingress"
  from_port                = "22"
  to_port                  = "22"
  protocol                 = "tcp"
  source_security_group_id = module.ansible_sg.id
  security_group_id        = module.backend_sg.id
}

resource "aws_security_group_rule" "frontend_ansible" {
  type                     = "ingress"
  from_port                = "22"
  to_port                  = "22"
  protocol                 = "tcp"
  source_security_group_id = module.ansible_sg.id
  security_group_id        = module.frontend_sg.id
}

resource "aws_security_group_rule" "ansible_public" {
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.ansible_sg.id
}

resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.id
}
