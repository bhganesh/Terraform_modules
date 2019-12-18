resource "aws_vpc" "qavpc" {
  cidr_block       = var.vpc_cidr_block
  
  tags = {
    #Name of the VPC and also Tag
    Name = var.vpc_tag_name
  	environment = var.environment
	  Terraform = var.Terraform
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.qavpc.id

  tags = {
    #Name of the VPC and Tag
    Name = var.Internetgateway_name
  }
}
