output "challenge_static_website" {
  value = aws_route53_record.challenge_record.name
}

output "alb_dns" {
  value = aws_lb.challenge_alb.dns_name
}