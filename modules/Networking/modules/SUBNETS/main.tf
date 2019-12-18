#CREATING PRIVATE SUBNETS
resource "aws_subnet" "private_subnets" {
	#Number of Subnets
    count = length(var.private_subnets)
	  vpc_id = var.vpc_id #To get VPC ID
	#To get the value of CIDR , which is mentioned in the variables file
    cidr_block = lookup(var.private_subnets[count.index],"pri_cidr_block")
    availability_zone = lookup(var.private_subnets[count.index],"pri_availability_zone")
    map_public_ip_on_launch = false

  tags = {
    # Name of the subnet and also tag
    Name = lookup(var.private_subnets[count.index],"Name")
	environment = var.environment
	Terraform = var.Terraform
  }
}

#CREATING PUBLIC SUBNETS
resource "aws_subnet" "public_subnets" {
   count = length(var.public_subnets)
	vpc_id = var.vpc_id #To get VPC ID
  cidr_block = lookup(var.public_subnets[count.index],"pub_cidr_block")
  availability_zone = lookup(var.public_subnets[count.index],"pub_availability_zone")
  #map_public_ip_on_launch = true

  tags = {
    Name = lookup(var.public_subnets[count.index],"Name")
	environment = var.environment
	Terraform = var.Terraform
  }
}


#CREATING PUBLIC ROUTE TABLE
resource "aws_route_table" "publicsubnetroutetable" {
  vpc_id = var.vpc_id
  
  #Adding route to route table
  route {
	 #Assigning CIDR and Internet gateway 
	 cidr_block = var.public_route_cidr_block
     gateway_id = var.Internetgateway_name
  }
  tags = {
    # Name of the Subnet and Tag
    Name = var.publicroutename
  }
}

#ASSOCIATING PUBLIC SUBNETS AND PUBLIC ROUTES
#subnet association , Adding subnets to Route Table
resource "aws_route_table_association" "publicrouteassociation"{
count = length(var.public_subnets)
subnet_id = aws_subnet.public_subnets.*.id[count.index]
route_table_id = aws_route_table.publicsubnetroutetable.id
}

#CREATING ELASTIC IP
resource "aws_eip" "elasticip" {
#Length of the Elastic IP List
 count = length(var.elasticip)
    vpc      = true
    tags = {
        Name = lookup(var.elasticip[count.index],"Name")
    }
}

#CREATING NATGATEWAY
resource "aws_nat_gateway" "natgateway" {
  count = length(var.elasticip)
	# creating natgate way , based on the count of elastic ip
	allocation_id = aws_eip.elasticip.*.id[count.index]
	subnet_id = aws_subnet.public_subnets.*.id[count.index]

    tags = {
		# Name of the natgateway and tag
       Name = lookup(var.natgateway[count.index],"Name")
    }
}

#CREATING PUBLIC SUBNET ROUTE TABLE
 resource "aws_route_table" "privatesubnetroutetable" {
  vpc_id = var.vpc_id
  count = length(var.natgateway)
  #assigning natgate way to route
  route {
    cidr_block = "0.0.0.0/0"
	gateway_id = aws_nat_gateway.natgateway.*.id[count.index]
  }
  
  tags = {
    Name = lookup(var.privatesubnetroutetable[count.index],"Name")
   
  }
} 

#CREATING PUBLIC SUBNET ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "privaterouteassociation"{
	count = length(var.private_subnets)
	subnet_id = aws_subnet.private_subnets.*.id[count.index]
	route_table_id = aws_route_table.privatesubnetroutetable[count.index].id
}

