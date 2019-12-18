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

variable public_security_id{
 type = string

}

variable public_subnets{
    type = list
}

variable targetport80{
 type = list

}

variable vpc_id {
    type = string
}

variable httplistnersuser{
type = list

}

variable http80{

    type = list
}
variable privateinstance_id{
    type = list
}