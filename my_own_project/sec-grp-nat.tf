resource "aws_security_group" "sec-nat" {
  name = "nat-sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = aws_vpc.my_vpc.id
  tags = { Name = "NAT-SecurityGroup" }

  ingress = [
    {
      description = "Ingress CIDR"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [var.vpc_cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = true
    }
  ]
  
  egress = [
    {
      description = "Default egress"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = true
    }
  ]
}