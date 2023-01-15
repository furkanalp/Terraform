resource "aws_security_group" "rds-sg" {
  name        = "rds-sg"
  description = "Access to MySQL DB for entire VPC CIDR Block"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description      = "MySQL access from within VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [ aws_security_group.private-sg.id, aws_security_group.bastion_sg.id ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}