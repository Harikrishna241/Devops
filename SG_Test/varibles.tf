variable "project_name" {
    type = string
    default = "Roboshp"
  
}

variable "environmeent" {
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

variable "Sec_desciption" {
    default = "roboshp"
  
}

variable "Sec_name" {
    default = "sg fr therobohopproject"
  
}

variable "vpc_id" {
    default = "vpc-0df478773d3a64d2e"
  
}