# output "ec2_bastion_public_instance_ids" {
#   description = "List of IDs of instances"
#   value       = aws_instance.ec2_bastion.id
# }

# output "ec2_bastion_public_ip" {
#   description = "List of public IP addresses assigned to the instances"
#   value       = aws_instance.ec2_bastion.public_ip 
# }

# output "app1_ec2_private_instance_ids" {
#   description = "List of IDs of instances"
#   value       = aws_instance.ec2_private_app1[count.index].id
# }

# output "app1_ec2_private_ip" {
#   description = "List of private IP addresses assigned to the instances"
#   value       = aws_instance.ec2_private_app1[count.index].private_ip 
# }

# output "app2_ec2_private_instance_ids" {
#   description = "List of IDs of instances"
#   value       = aws_instance.ec2_private_app2[count.index].id
# }

# output "app2_ec2_private_ip" {
#   description = "List of private IP addresses assigned to the instances"
#   value       = aws_instance.ec2_private_app2[count.index].private_ip 
# }

# output "app3_ec2_private_instance_ids" {
#   description = "List of IDs of instances"
#   value       = aws_instance.ec2_private_app3[count.index].id
# }

# output "app3_ec2_private_ip" {
#   description = "List of private IP addresses assigned to the instances"
#   value       = aws_instance.ec2_private_app3[count.index].private_ip
# }