#Added Route 53 record Alias record
resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = var.Route53_name
  type    = var.type

  alias {
   # name   = aws_lb.applicationLB.dns_name
   #Application Load Balancer DNS name
   name = var.aplb_dns
   #Application load Balancer Zone ID
    zone_id  = var.aplb_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}