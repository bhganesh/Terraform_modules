output "privatesubnet_ids" {
	value = aws_subnet.private_subnets.*.id
}

output "publicsubnet_ids" {
	value = aws_subnet.public_subnets.*.id
}

output "publicsubnetroutetable_ids" {
	value = aws_route_table.publicsubnetroutetable.id
}

output "elasticIP_ids" {
	value = aws_eip.elasticip.*.id
}

output "natgatway_ids" {
	value = aws_nat_gateway.natgateway.*.id
}

output "privatesubnetroutetable_ids" {
	value = aws_route_table.privatesubnetroutetable.*.id
}