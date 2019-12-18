
output "aws_db_instance_id" {
    value = aws_db_instance.MyDatabase.id
}

output "aws_db_instance_name" {
    value = aws_db_instance.MyDatabase.name
}

output "aws_db_instance_resource_id" {
    value = aws_db_instance.MyDatabase.resource_id
}