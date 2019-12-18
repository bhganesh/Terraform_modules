module "VPC" {
    source = "./modules/Networking/modules/VPC"
    vpc_cidr_block = var.vpc_cidr_block
    vpc_tag_name = var.vpc_tag_name
    environment = var.environment
    Terraform = var.Terraform
    Internetgateway_name = var.Internetgateway_name
}


module "SUBNETS" {
    # passing VPC id to the subnets by getting from Output values of the VPC module
    vpc_id = module.VPC.vpc_id

    source = "./modules/Networking/modules/SUBNETS"
    private_subnets = var.private_subnets  # passing List of subnets from QAtfvars to subnets module
    public_subnets = var.public_subnets
    environment = var.environment
    Terraform = var.Terraform
    

    #Public route tabels
    public_route_cidr_block = var.public_route_cidr_block
    publicroutename = var.publicroutename
    Internetgateway_name = module.VPC.IG  # GETTING INTERNET GATEWAY FROM MODULES

     elasticip = var.elasticip
     natgateway = var.natgateway
     privatesubnetroutetable = var.privatesubnetroutetable
}


module "instance" {
    vpc_id = module.VPC.vpc_id
    source = "./modules/instance"
    publicinstance = var.publicinstance
    privateinstance = var.privateinstance

    #GETTING SUBNETS FROM SUBNET MODULE
    # need to define variable public_subnets  in  instance modules variables.tf file
     public_subnets   =  module.SUBNETS.publicsubnet_ids
     private_subnets   =  module.SUBNETS.privatesubnet_ids
     
     public_security_id   =  module.Security.publicsecuritygroup_id
}

module "Security" {
   
    source = "./modules/Security"
   vpc_id = module.VPC.vpc_id
  
 publicseccuritygroup_name = var.publicseccuritygroup_name
publicseccuritydescription = var.publicseccuritydescription
psfrom_port   = var.psfrom_port
psto_port     = var.psto_port
psprotocol    = var.psprotocol
CIDR_ZEROBLOCKS = var.CIDR_ZEROBLOCKS

ps2from_port   = var.ps2from_port
ps2to_port     = var.ps2to_port
ps2protocol    = var.ps2protocol

	
egresfrom_port = var.egresfrom_port
egresto_port = var.egresto_port
egresprotocol = var.egresprotocol

 

}

module "ALB" {
source = "./modules/ALB"
public_subnets   =  module.SUBNETS.publicsubnet_ids
AppLBname = var.AppLBname
AppLBinternal =  var.AppLBinternal
AppLBload_balancer_type =  var.AppLBload_balancer_type
AppLBenable_deletion_protection =  var.AppLBenable_deletion_protection
AppLBEnvironment =  var.AppLBEnvironment
public_security_id   =  module.Security.publicsecuritygroup_id


targetport80 = var.targetport80
vpc_id = module.VPC.vpc_id

httplistnersuser = var.httplistnersuser


#added to solve Bug
privateinstance_id = module.instance.privateinstance_id

http80 = var.http80

} 

#For Route53
module Route53 {
    source = "./modules/Route53"
    zone_id = var.zone_id
    Route53_name    = var.Route53_name
    type    = var.type
    evaluate_target_health = var.evaluate_target_health
    aplb_dns = module.ALB.applicationLB_dns
    aplb_zone_id = module.ALB.applicationLB_zone_id
}

#For AutoScaling
module AutoScaling {
    source = "./modules/AutoScaling"

    name   = var.name
    image_id  = var.image_id
    instance_type = var.instance_type
    key_name   = var.key_name
    #user_data   = "./user-data/user-data-prv1.sh"
    user_data = var.user_data
    private_subnets   =  module.SUBNETS.privatesubnet_ids

    targetgroup_arn =  module.ALB.targetport80_id

     public_security_id   =  module.Security.publicsecuritygroup_id

    autoscalename                 = var.autoscalename
    autoscalemin_size             =  var.autoscalemin_size
    autoscalemax_size             =  var.autoscalemax_size
    autoscalehealth_check_grace_period =  var.autoscalehealth_check_grace_period
    autoscalehealth_check_type =  var.autoscalehealth_check_type
    autoscaledesired_capacity =  var.autoscaledesired_capacity
    autoscaleforce_delete =  var.autoscaleforce_delete
    
}

module Database {
    source = "./modules/Database"
    database_details = var.database_details
    #vpc_security_group_ids = module.VPC.vpc_id
    public_subnets_database   =  module.SUBNETS.publicsubnet_ids  
}
  
    