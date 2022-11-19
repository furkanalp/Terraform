terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.39.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  mytag = "cyotex-local-name"
}

resource "aws_instance" "tf-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  key_name      = "My_Key"
  tags = {
    "Name" = "${local.mytag}-comes-from-locals"
  }
}



resource "aws_s3_bucket" "tf-s3" {
  #bucket = "${var.s3_bucket_name}-${count.index}"
  #count = var.num_of_buckets
  #count = var.num_of_buckets !=0 ? var.num_of_buckets : 3
  for_each = toset(var.users)
  bucket = "example-tf-s3-bucket-cyotex-${each.value}"
}

resource "aws_iam_user" "new_users" {
  for_each = toset(var.users)
  name = each.value
}

output "uppercase_users" {
  value = [for user in var.users : upper(user) if length(user) > 6]
}

output "tf_example_public_ip" {
  value = aws_instance.tf-ec2.public_ip
}

# output "tf_example_s3_meta" {
#   value = aws_s3_bucket.tf-s3.region
# }

output "tf_example_private_ip" {
  value = aws_instance.tf-ec2.private_ip
}

# output "tf_example_s3_meta_2" {
#   value = aws_s3_bucket.tf-s3.*.bucket
# }

output "tf_example_s3_meta_2" {
  value = values(aws_s3_bucket.tf-s3)[*].bucket
}