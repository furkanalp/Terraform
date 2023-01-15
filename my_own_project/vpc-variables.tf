# VPC Name
variable "vpc_name" {
  description = "VPC Name"
  type = string 
  default = "my_vpc"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type = string 
  default = "10.0.0.0/16"
}

# VPC Availability Zones
variable "availability_zone_public_subnet" {
  description = "VPC Availability Zone for BastionHost"
  default = "us-east-1a"
}

# VPC Public Subnet
variable "public_subnet" {
  description = "VPC Public Subnet "
  default     = "10.0.101.0/24"
}

variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnets CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "database_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.151.0/24", "10.0.152.0/24"]
}

variable "azs" {
  description = "Availability Zones for vpc"
  default =["us-east-1a","us-east-1b" ]
}













