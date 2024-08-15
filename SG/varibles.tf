variable "vpc_id" {

    default = "vpc-0df478773d3a64d2e"
  
}
variable "outbound_rules" {
  
    type =  list
    default=[
         {
            from_port        = 0
            to_port          = 0
            protocol         = "-1"
            cidr_blocks      = ["0.0.0.0/0"]
         }
        ]
  
}

variable "inbound_rules" {
  
    type =  list
    default=[
        #  {
        #     from_port        = 0
        #     to_port          = 0
        #     protocol         = "-1"
        #     cidr_blocks      = ["0.0.0.0/0"]
        #  }
        ]
  
}

variable "environment" {
    type = string
    default = "dev"
  
}

variable "project_name" {
    type = string
    default = "Rboshop"
  
}

variable "common_tags" {
    type = map
    default = {
        Name = "expense"
        Environment = "Dev"
    }
}

variable "sg_name" {
    type = string
    default = "Rboshop"
    
  
}

variable "sg_description" {
    type = string
    default = "Rboshop"
    
  
}