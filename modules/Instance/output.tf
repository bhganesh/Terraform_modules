output "publicinstance_id" {
    value = aws_instance.publicinstance.*.id
}

output "privateinstance_id" {
    value = aws_instance.privateinstance.*.id
}
