variable "domain_name" {
  default = "devopsmikail.link" #############################
}

data "aws_acm_certificate" "acm-cert" {
  domain   = var.domain_name
  statuses = ["ISSUED"]
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn = data.aws_acm_certificate.acm-cert.arn
}

