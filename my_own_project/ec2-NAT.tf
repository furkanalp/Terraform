data "aws_ami" "nat-ec2" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn-ami-vpc-nat-2018.03.0.20220419.0*" ]
  }
}

resource "aws_eip" "lb" {
  depends_on = [aws_internet_gateway.my_igw]
  instance = aws_instance.ec2_nat.id
  vpc      = true
}


resource "aws_instance" "ec2_nat" {
  ami                    = data.aws_ami.nat-ec2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  
  network_interface {
    network_interface_id = aws_network_interface.eni.id
    device_index = 0
  }
  tags                   = { Name = "NAT-Instance" } 
  user_data = <<EOT
#!/bin/bash
sudo /usr/bin/apt update
sudo /usr/bin/apt install ifupdown
/bin/echo '#!/bin/bash
if [[ $(sudo /usr/sbin/iptables -t nat -L) != *"MASQUERADE"* ]]; then
  /bin/echo 1 > /proc/sys/net/ipv4/ip_forward
  /usr/sbin/iptables -t nat -A POSTROUTING -s ${var.vpc_cidr_block} -j MASQUERADE
fi
' | sudo /usr/bin/tee /etc/network/if-pre-up.d/nat-setup
sudo chmod +x /etc/network/if-pre-up.d/nat-setup
sudo /etc/network/if-pre-up.d/nat-setup 
  EOT
}

resource "aws_network_interface" "eni" {
  subnet_id              = aws_subnet.public_subnet.id
  source_dest_check      = false
  security_groups = [aws_security_group.sec-nat.id]
  tags = {
    Name = "nat_instance_network_interface"
  }
}

