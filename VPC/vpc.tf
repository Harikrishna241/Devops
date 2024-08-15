#module development for roboshop VPC
resource "aws_vpc" "main" {
    cidr_block       = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true
    

    tags = merge(var.common_tags,{
        Name = "${var.project_name}-${var.environment}"
    }
  )
}

#now creating the internet gateway 
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id

    tags = merge(var.common_tags,{
        Name = "${var.project_name}-${var.environment}"
    }
  )
}

#Now creating of subnets 

#db subnet 

resource "aws_subnet" "db" {
    count = length(var.db-subnet-cidrs)    
    vpc_id     = aws_vpc.main.id
    cidr_block = var.db-subnet-cidrs[count.index]
    availability_zone = local.avaialble_zones[count.index]
    
    

        tags = merge(var.common_tags,{
            Name = "${var.project_name}-${var.environment}-private-subnet-db-${local.avaialble_zones[count.index]}"
        }
    )
}

#Backend subnet
resource "aws_subnet" "backend" {
    count = length(var.privte-subnet-cidrs)    
    vpc_id     = aws_vpc.main.id
    cidr_block = (var.privte-subnet-cidrs[count.index])
    availability_zone = local.avaialble_zones[count.index]

        tags = merge(var.common_tags,{
            Name = "${var.project_name}-${var.environment}-private-subnet-bckend-${local.avaialble_zones[count.index]}"
        }
    )
}

#Frontend subnet
resource "aws_subnet" "frontend" {
    count = length(var.public-subnet-cidrs)    
    vpc_id     = aws_vpc.main.id
    cidr_block = var.public-subnet-cidrs[count.index]
    availability_zone = local.avaialble_zones[count.index]

        tags = merge(var.common_tags,{
            Name = "${var.project_name}-${var.environment}-public-subnet-frontend-${local.avaialble_zones[count.index]}"
        }
    )
}

#Creating of route tables

#creating db route table 
resource "aws_route_table" "db_private_route_tabel" {
  vpc_id = aws_vpc.main.id



          tags = merge(var.common_tags,{
            Name = "${var.project_name}-${var.environment}-db-private-route-table"
            }
          )
}

#creating backend route table 
resource "aws_route_table" "backend_private_route_tabel" {
  vpc_id = aws_vpc.main.id



          tags = merge(var.common_tags,{
            Name = "${var.project_name}-${var.environment}-backend-private-route-table"
            }
          )
}

#creating frontend route table 
resource "aws_route_table" "public_route_tabel" {
  vpc_id = aws_vpc.main.id



          tags = merge(var.common_tags,{
            Name = "${var.project_name}-${var.environment}-public-route-table"
            }
          )
}

#creating NAT gateway 

#creating eib
resource "aws_eip" "roboshop" {
    domain   = "vpc"

    tags = merge(var.common_tags,{
            Name = "${var.project_name}-${var.environment}-Natgaatway"
        }
     )
}

resource "aws_nat_gateway" "gw" {
  subnet_id = aws_subnet.frontend[0].id
  allocation_id = aws_eip.roboshop.id


            tags = merge(var.common_tags,{
            Name = "${var.project_name}-${var.environment}-Natgaatway"
            }
          )
}

#creating routes 

#db routes 
resource "aws_route" "db-privte-routes" {
   
    route_table_id            = aws_route_table.db_private_route_tabel.id
    destination_cidr_block    = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gw.id
}


resource "aws_route" "backend-privte-routes" {
    
    route_table_id            = aws_route_table.backend_private_route_tabel.id
    destination_cidr_block    = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gw.id
}


resource "aws_route" "frontend-public-routes" {
    
    route_table_id            = aws_route_table.public_route_tabel.id
    destination_cidr_block    = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
}


#route table association 
resource "aws_route_table_association" "public_route_tabel_association" {
    count = length(var.public-subnet-cidrs) 
    subnet_id      = element(aws_subnet.frontend[*].id,count.index)
    route_table_id = aws_route_table.public_route_tabel.id
}

resource "aws_route_table_association" "private_tabel_association" {
    count = length(var.public-subnet-cidrs) 
    subnet_id      = element(aws_subnet.backend[*].id,count.index)
    route_table_id = aws_route_table.backend_private_route_tabel.id
}


resource "aws_route_table_association" "db_private_route_tabel" {
    count = length(var.db-subnet-cidrs) 
    subnet_id      = element(aws_subnet.db[*].id,count.index)
    route_table_id = aws_route_table.db_private_route_tabel.id
}