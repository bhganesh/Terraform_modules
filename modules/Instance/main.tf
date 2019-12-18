resource "aws_instance" "publicinstance" {

    # vpc_id = var.vpc_id #To get VPC ID
    count = length(var.publicinstance)
	ami = lookup(var.publicinstance[count.index],"ami_id")
	instance_type = lookup(var.publicinstance[count.index],"instance_type")
	key_name = lookup(var.publicinstance[count.index],"keyname")
	
	associate_public_ip_address = 	lookup(var.publicinstance[count.index],"associate_public_ip_address")
	availability_zone = lookup(var.publicinstance[count.index],"availability_zone")
	# This will add security group , to the instance. So , default sec group will not add.
	#vpc_security_group_ids  = aws_security_group.publicseccuritygroup.*.id
	vpc_security_group_ids  = [var.public_security_id]

 

    #received subnet id from subnet modules as mention in base main.tf file and used  here
	subnet_id = var.public_subnets[count.index]
    
	tags = {
		Name= lookup(var.publicinstance[count.index],"Name")
	}
}


resource "aws_instance" "privateinstance" {

	count = length(var.privateinstance)
	ami = lookup(var.privateinstance[count.index],"ami_id")
	instance_type = lookup(var.privateinstance[count.index],"instance_type")
	key_name = lookup(var.privateinstance[count.index],"keyname")
	#subnet_id = aws_subnet.private_subnets.*.id[count.index]
    subnet_id = var.private_subnets[count.index]
	associate_public_ip_address = 	lookup(var.privateinstance[count.index],"associate_public_ip_address")
	availability_zone = lookup(var.privateinstance[count.index],"availability_zone")
	#Need to ask sir why this is security group not coming with out * symbol
    vpc_security_group_ids  = [var.public_security_id]
	user_data = file(lookup(var.privateinstance[count.index],"user_data"))
	tags = {
		Name= lookup(var.privateinstance[count.index],"Name")
	}
}