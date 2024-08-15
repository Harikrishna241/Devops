module "jenkins-master" {
    source = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.workstation.id
    instance_type = var.instance_type
    vpc_security_group_ids = var.sg_id
    name = "jenkins-master"
    user_data = file("jenkin.sh")

    tags = {
        Terraform   = "true"
        Environment = "dev"
    }
}

module "jenkins-agent" {
    source = "terraform-aws-modules/ec2-instance/aws"
    ami = data.aws_ami.workstation.id
    instance_type = var.instance_type
    vpc_security_group_ids = var.sg_id
    name = "jenkins-agent"
    user_data = file("jenkins-agent.sh")

    tags = {
        Terraform   = "true"
        Environment = "dev"
    }
}

resource "aws_key_pair" "tools" {
  key_name   = "tools"
  # you can paste the public key directly like this
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIvG4mGMsVq7hUdv6Pz1/Bh2/Qhxp6hXZU9Z+UZI7GK8 prudh@LAPTOP-F6I9R2EN"
  #public_key = file("~/.ssh/tools.pub")
  # ~ means windows home directory
}

module "nexus" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "nexus"

  instance_type          = "t3.medium"
  vpc_security_group_ids = var.sg_id
  # convert StringList to list and get first element
  #subnet_id = "subnet-0ea509ad4cba242d7"
  ami = data.aws_ami.nexus_ami_info.id
  key_name = aws_key_pair.tools.key_name
  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = 30
    }
  ]
  tags = {
    Name = "nexus"
  }
}