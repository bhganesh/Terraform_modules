variable private_subnets{
    type = list
}

variable vpc_id{
  type = string
}

variable environment{
	type = string
}


variable Terraform{
	type = string
}

variable public_subnets{
    type = list
}

#Public Route Variables
variable public_route_cidr_block{
    type = string
}

variable Internetgateway_name{
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