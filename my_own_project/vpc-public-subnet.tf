resource "aws_subnet" "public_subnet" {
 vpc_id     = aws_vpc.my_vpc.id
 cidr_block = var.public_subnet
 availability_zone = var.availability_zone_public_subnet
 tags = {
   Name = "Public Subnet "
 }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "public_route_table"
  }
}


resource "aws_route_table_association" "public_subnet_asso" {
 subnet_id      = aws_subnet.public_subnet.id
 route_table_id = aws_route_table.public_route_table.id
}
