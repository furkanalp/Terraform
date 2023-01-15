resource "aws_instance" "ec2_private_app2" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  count = var.private_instance_count
  subnet_id = "${element(data.aws_subnets.private.ids, count.index)}"
  vpc_security_group_ids = [ aws_security_group.private-sg.id ]
  user_data = filebase64("${abspath(path.module)}/app2-install.sh")

  tags = {
    Name = "ec2_private_app2-${count.index}"
  }
}
