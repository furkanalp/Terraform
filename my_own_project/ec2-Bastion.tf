
resource "aws_instance" "ec2_bastion" {
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]  
  subnet_id              = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  user_data = filebase64("${abspath(path.module)}/jumpbox-install.sh")
  tags = {Name = "BastionHost"} 
}