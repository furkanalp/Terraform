resource "aws_subnet" "database_subnets" {
 count      = length(var.database_subnet_cidrs)
 vpc_id     = aws_vpc.my_vpc.id
 cidr_block = element(var.database_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 tags = {
   Name = "Database Subnet ${count.index + 1}"
   Tier = "database"
 }
}

resource "aws_route_table" "database_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id = aws_network_interface.eni.id
  }
  tags = {
    Name = "database_route_table"
  }
}

resource "aws_route_table_association" "database_subnet_asso" {
 count = length(var.database_subnet_cidrs)
 subnet_id      = element(aws_subnet.database_subnets[*].id, count.index)
 route_table_id = aws_route_table.database_route_table.id
}