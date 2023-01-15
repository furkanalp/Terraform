resource "aws_db_instance" "rdsdb" {
  depends_on = [
    aws_db_subnet_group.default
  ]
  allocated_storage    = 20
  db_name              = var.db_name
  engine               = "mysql"
  engine_version       = "8.0.23"
  instance_class       = "db.t2.micro"
  vpc_security_group_ids = [ aws_security_group.rds-sg.id ] # updated.
  allow_major_version_upgrade = false
  auto_minor_version_upgrade = true
  backup_retention_period = 0
  identifier = var.db_instance_identifier
  monitoring_interval = 0
  multi_az = false
  port = 3306
  publicly_accessible = false
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  deletion_protection = false
  db_subnet_group_name = aws_db_subnet_group.default.name
}

data "aws_subnets" "database_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.my_vpc.id]
  }
  
  tags = {
    Tier = "database"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "dbsubnetgroup"
  subnet_ids = aws_subnet.database_subnets.*.id

  tags = {
    Name = "My DB subnet group"
  }
}