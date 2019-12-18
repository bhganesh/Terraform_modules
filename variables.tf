variable region{
	type = string
}

variable vpc_cidr_block{
	type = string
}


variable vpc_tag_name{
	type = string
}


variable environment{
	type = string
}


variable Terraform{
	type = string
}

variable Internetgateway_name{
    type = string
}

variable private_subnets{
    type = list
}

variable public_subnets{
    type = list
}

#Public Route variables
variable public_route_cidr_block{
    type = string
}

variable publicroutename{
    type = string
}

variable elasticip{
   type = list
}

variable natgateway{
	type = list
}

variable  privatesubnetroutetable{
 type = list
}

variable publicinstance {

	type = list
}  

#Public security group




variable publicseccuritygroup_name{
  type = string
}
variable publicseccuritydescription{
  type = string
}

variable psfrom_port{
  type = string
}


variable psto_port{
  type = string
}


variable psprotocol{
  type = string
}


variable CIDR_ZEROBLOCKS{
  type = string
}



variable ps2from_port{
  type = string
}


variable ps2to_port{
  type = string
}


variable ps2protocol{
  type = string
}


	

variable egresfrom_port{
  type = string
}


variable egresto_port{
  type = string
}


variable egresprotocol{
  type = string
}


#private instance
variable privateinstance {

	type = list
}  

#Load Balancer
variable AppLBname {

	type = string
}  

variable AppLBinternal {

	type = string
}  

variable AppLBload_balancer_type {

	type = string
}  

variable AppLBenable_deletion_protection {

	type = string
}  

variable AppLBEnvironment {

	type = string
}  

variable targetport80 {
	type = list
}

variable httplistnersuser{
	type = list
} 

variable http80 {
type = list 

} 


#For Route53
variable zone_id {
   type = string
}


variable Route53_name {
   type = string
}


variable type {
   type = string
}


variable evaluate_target_health {
   type = string
}


#Auto scaling
variable name{
  type = string
}

variable image_id{
  type = string
}

variable instance_type{
  type = string
}

variable key_name{
  type = string
}


#Autoscale group
variable autoscalename{
    type = string
}
variable autoscalemin_size{
    type = string
}
variable autoscalemax_size{
    type = string
}
variable autoscalehealth_check_grace_period{
    type = string
}
variable autoscalehealth_check_type{
    type = string
}
variable autoscaledesired_capacity{
    type = string
}
variable autoscaleforce_delete{
    type = string
}
variable user_data {
	type = string
}

#Database storage is 5 
variable database_details {
	type = map
}