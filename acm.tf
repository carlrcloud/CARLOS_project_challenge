
# Find a certificate issued by (not imported into) ACM

data "aws_acm_certificate" "amazon_issued" {
  domain      = "*.${var.my_zone}"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

data "aws_route53_zone" "my_zone" {
  name         = var.my_zone
  private_zone = false
}

resource "aws_route53_record" "challenge_record" {
  zone_id = data.aws_route53_zone.my_zone.zone_id
  name    = "challenge.${var.my_zone}"
  type    = "A"

  alias {
    name                   = aws_lb.challenge_alb.dns_name
    zone_id                = aws_lb.challenge_alb.zone_id
    evaluate_target_health = true
  }
}
