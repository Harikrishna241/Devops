variable "instance_type" {
    type = string
    default = "t3.small"
  
}
variable "sg_id" {
    type = list
    default = ["sg-0b9862f17cf5ec5fe"]
  
}