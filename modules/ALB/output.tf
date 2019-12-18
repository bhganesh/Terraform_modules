output "applicationLB_id" {
    value = aws_lb.applicationLB.id
}
output "targetport80_id" {
    value = aws_lb_target_group.targetport80.*.id
}

output "applicationLB_dns" {
    value = aws_lb.applicationLB.dns_name
}

output "applicationLB_zone_id" {
    value = aws_lb.applicationLB.zone_id
}


