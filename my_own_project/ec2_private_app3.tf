resource "aws_instance" "ec2_private_app3" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  count = var.private_instance_count
  subnet_id = "${element(data.aws_subnets.private.ids, count.index)}"
  vpc_security_group_ids = [ aws_security_group.private-sg.id ]
  user_data = data.template_file.app3.rendered

  tags = {
    Name = "ec2_private_app3-${count.index}"
  }
}

data "template_file" "app3" {
  template = "${file("${abspath(path.module)}/app3-ums-install.tpl")}"
  vars = {
    rds_db_endpoint = "${aws_db_instance.rdsdb.address}" #updated.
  }
}