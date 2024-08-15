
# module "db" {
#     source = "../SG"
#     vpc_id = module.vpc.vpc_id
#     project_name = var.project_name
#     environment = var.environmeent
#     common_tags = var.common_tags
#     sg_description = "this is for the db" 
#     sg_name = "db"
# }

# module "backend" {
#     source = "../SG"
#     vpc_id = module.vpc.vpc_id
#     project_name = var.project_name
#     environment = var.environmeent
#     common_tags = var.common_tags
#     sg_description = "SG for backend Instances"    
#     sg_name = "db"
# }

module "vpc" {
    source = "../VPC"
    
}

module "frontend" {
    source = "../SG"
    vpc_id = var.vpc_id
    project_name = var.project_name
    environment = var.environmeent
    common_tags = var.common_tags
    sg_description = "SG for frontend Instances"    
    sg_name = "robo fontid"
}

#security check rules for individual modules 

resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend.sg_id
}
   

