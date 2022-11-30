variable "private_key" {
  default = "My_Key.pem"
}

variable "key_name" {
  default = "My_Key"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet1_cidr" {
  default = "10.0.2.0/24"
}