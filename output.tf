output "vpc_id" {
    value = module.VPC.vpc_id
}
output "IG"{
value = module.VPC.IG
}
output "privatesubnet_ids" {
	value = module.SUBNETS.privatesubnet_ids
}

output "publicsubnet_ids" {
	value = module.SUBNETS.publicsubnet_ids
}

output "publicsubnetroutetable_ids" {
	value = module.SUBNETS.publicsubnetroutetable_ids
}

output "elasticIP_ids" {
	value =  module.SUBNETS.elasticIP_ids
}
output "natgatway_ids" {
	value = module.SUBNETS.natgatway_ids
}
output "privatesubnetroutetable_ids" {
	value = module.SUBNETS.privatesubnetroutetable_ids
}

output "publicinstance_id" {
    value = module.instance.publicinstance_id
}
output "privateinstance_id" {
    value = module.instance.privateinstance_id
}
output "publicsecuritygroup_id" {
    value = module.Security.publicsecuritygroup_id
}
output "applicationLB_id" {
    value = module.ALB.applicationLB_id
}
output "targetport80_id" {
    value = module.ALB.targetport80_id
}

#Added for Route 53
output "applicationLB_dns" {
    value = module.ALB.applicationLB_dns
}
output "applicationLB_zone_id" {
    value = module.ALB.applicationLB_zone_id
}
output "aws_launch_configuration_name" {
    value = module.AutoScaling.aws_launch_configuration_name
    
}
output "aws_launch_configuration_image_id" {
    value = module.AutoScaling.aws_launch_configuration_image_id
}

#Database
output "aws_db_instance_id" {
    value = module.Database.aws_db_instance_id
}
output "aws_db_instance_name" {
    
    value = module.Database.aws_db_instance_name
}
output "aws_db_instance_resource_id" {
    
    value = module.Database.aws_db_instance_resource_id
}