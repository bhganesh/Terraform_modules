output "vpc_id" {
    value = aws_vpc.qavpc.id
}

output "IG"{
value = aws_internet_gateway.gw.id
}


