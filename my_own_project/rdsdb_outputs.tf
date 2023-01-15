output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.rdsdb.address
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = aws_db_instance.rdsdb.availability_zone
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.rdsdb.endpoint
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = aws_db_instance.rdsdb.status
}

output "db_instance_name" {
  description = "The database name"
  value       = aws_db_instance.rdsdb.db_name
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = aws_db_instance.rdsdb.username
}

output "db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = aws_db_instance.rdsdb.password
  sensitive = true
}

output "db_subnet_group_id" {
  description = "The db subnet group name"
  value       = aws_db_instance.rdsdb.db_subnet_group_name
}