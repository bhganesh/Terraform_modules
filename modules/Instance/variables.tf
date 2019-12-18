#publicinstance = var.publicinstances


variable publicinstance{
  type = list
}

variable privateinstance{
  type = list
}


variable public_subnets{
    type = list
}

variable private_subnets{
    type = list
}
/*
variable vpc_id{
  type = string
}
*/

variable vpc_id{
  type = string
}

variable public_security_id{
    type = string
}

