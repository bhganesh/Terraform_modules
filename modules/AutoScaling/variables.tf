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

variable user_data{
    type = string
}

#Auto scale group
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
variable private_subnets{
    type = list
}

variable targetgroup_arn{
    type = list
}

variable public_security_id{

    type = string
}