variable "ec2_name" {
  default = "cyotex-ec2"
}

variable "ec2_type" {
  default = "t2.micro"
}

variable "ec2_ami" {
  default = "ami-0b0dcb5067f052a63"
}
variable "s3_bucket_name" {
  default = "cyotex-s3-bucket-variable"
}

variable "num_of_buckets" {
  default = 2
}

variable "users" {
  default = ["santino", "michael", "freado"]
}