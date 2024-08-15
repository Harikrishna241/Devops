variable "project_name" {
    type = string
    default = "Roboshop"
}

variable "environment" {
    type = string
    default = "dev"
  
}

variable "common_tags" {
    type = map
    default = {
        Name = "expense"
        Environment = "Dev"
    }
}

# user might change the efult CIDR data 
variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

#internet gateway variables 

variable "db-subnet-cidrs" {
    type = list
    default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "privte-subnet-cidrs" {
    type = list
    default = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "public-subnet-cidrs" {
    type = list
    default = ["10.0.5.0/24","10.0.6.0/24"]
}