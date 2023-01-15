resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr_block
  tags = {
    Name = "Project VPC"
  }
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
}







