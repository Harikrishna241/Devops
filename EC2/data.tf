data "aws_ami" "workstation" {
    owners = ["973714476881"]
    most_recent = true
    filter {
            name   = "name"
            values = ["RHEL-9-DevOps-Practice"]
        }
    
        filter {
            name   = "virtualization-type"
            values = ["hvm"]
        }
    
        filter {
            name   = "architecture"
            values = ["x86_64"]
        }
    
        #owners = ["099720109477"] # Canonical official
}

data "aws_ami" "nexus_ami_info" {

    most_recent = true
    owners = ["679593333241"]

    filter {
        name   = "name"
        values = ["SolveDevOps-Nexus-Server-Ubuntu20.04-20240511-*"]
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

