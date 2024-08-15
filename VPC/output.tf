output "az" {
    value = data.aws_availability_zones.available
  
}

output "public_subnet_id" {
    
    value = aws_subnet.frontend[*].id  
}

output "private_backend_subnet_id" {
    value = aws_subnet.backend[*].id
  
}

output "db_backend_subnet_id" {
    value = aws_subnet.db[*].id
  
}

output "vpc_id" {
    value = aws_vpc.main.id  
}
