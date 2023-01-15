data "aws_route53_zone" "my_hosted_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "route53_record" {
  depends_on = [
    aws_lb.my_elb
  ]
  zone_id = data.aws_route53_zone.my_hosted_zone.id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.my_elb.dns_name #eklenecek
    zone_id                = aws_lb.my_elb.zone_id #eklenecek.
    evaluate_target_health = true
  }
}