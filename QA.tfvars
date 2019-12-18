region  = "ap-south-1"
vpc_cidr_block = "10.100.0.0/16"
vpc_tag_name = "QA VPC"
environment = "QA"
Terraform = "True"
Internetgateway_name = "qa_internetgateway"

private_subnets = [{
			Name = "privatesubnet1"
		    pri_cidr_block = "10.100.100.0/24"
			pri_availability_zone = "ap-south-1a"
	},
	{
			Name = "privatesubnet2"
			pri_cidr_block = "10.100.101.0/24"
			pri_availability_zone = "ap-south-1b"
	}]

public_subnets = [{
			Name = "publicsubnet1"
		    pub_cidr_block = "10.100.1.0/24"
			pub_availability_zone = "ap-south-1a"
	},
	{
			Name = "publicsubnet2"
			pub_cidr_block = "10.100.2.0/24"
			pub_availability_zone = "ap-south-1b"
	}]

#Public Route Variables
public_route_cidr_block = "0.0.0.0/0"
publicroutename = "publicsubnetroutetable"

#For Private Route Table
elasticip = [{
		Name = "elasticIP1"
},
{
		Name = "elasticIP2"
}]

natgateway= [{
		Name = "publicsunbet1natgatway1"
	},
	{
		Name = "publicsunbet2natgatway2"
	}]

privatesubnetroutetable = [{
	#	cidr_private_route = "0.0.0.0/0"
		Name = "privatesubnetroutetable1"
	},
	{
	#	cidr_private_route = "0.0.0.0/0"
		Name = "privatesubnetroutetable2"
	}]

#Public Instance
publicinstance = [{
		ami_id = "ami-0123b531fc646552f"
		instance_type = "t2.micro"
		keyname = "newkeypair"
		associate_public_ip_address = "true"
		availability_zone = "ap-south-1a"
		Name = "public instance1"
		
		
	},
	{
		ami_id = "ami-0123b531fc646552f"
		instance_type = "t2.micro"
		keyname = "newkeypair"
		associate_public_ip_address = "true"
		availability_zone = "ap-south-1b"
		Name = "public instance2"
	}]

#Public security group
publicseccuritygroup_name = "publicseccuritygroup"
publicseccuritydescription = "Public instance security group"
psfrom_port   = "22"
psto_port     = "22"
psprotocol    = "TCP"
CIDR_ZEROBLOCKS = "0.0.0.0/0"

ps2from_port   = "80"
ps2to_port     = "80"
ps2protocol    = "TCP"
#ps2cidr_blocks = "0.0.0.0/0"
	
egresfrom_port = "0"
egresto_port = "0"
egresprotocol = "-1"
#egrescidr_blocks = "0.0.0.0/0"

privateinstance = [{
		ami_id = "ami-0123b531fc646552f"
		instance_type = "t2.micro"
		keyname = "newkeypair"
		associate_public_ip_address = "false"
		availability_zone = "ap-south-1a"
		Name = "private instance1"
		user_data = "install_apache1.sh"
	},
	{	
		ami_id = "ami-0123b531fc646552f"
		instance_type = "t2.micro"
		keyname = "newkeypair"
		associate_public_ip_address = "false"
		availability_zone = "ap-south-1b"
		Name = "private instance2"
		user_data = "install_apache2.sh"
	}]

AppLBname = "applicationLB"
AppLBinternal = "false"
AppLBload_balancer_type = "application"
AppLBenable_deletion_protection = "false"
AppLBEnvironment = "applicationLB"

#targetport80sales
targetport80 = [{
	port80_name     = "targetport80user"
	port80_port     = "80"
	port80_protocol = "HTTP"
	Name = "targetport80user1"
},
{
	port80_name     = "targetport80dashboard"
	port80_port     = "80"
	port80_protocol = "HTTP"
	Name = "targetport80dashboard1"
}]

httplistnersuser = [{
			httplistnersuser_port = "80"
			httplistnersuser_protocol = "HTTP"
			httplistnersuser_type = "forward"
	}
	
	,{
			httplistnersuser_port = "443"
			httplistnersuser_protocol = "HTTPS"
			httplistnersuser_type = "forward"
	} ]
	
	http80 = [{
				http80type = "forward"
				http80field = "path-pattern"
				http80values = "/user*"
	},
	{
				http80type = "forward"
				http80field = "path-pattern"
				http80values = "/dashboard*"
	}] 

	#For Route 53
	# This we got from "Hosted Zone Details" of Domain name in the Route53.
    zone_id = "Z16F8AQGOL5V1G"
    Route53_name    = "www.bhraju.in"
    type    = "A"
    evaluate_target_health = true

	#Auto scaling
	name   = "launchConfig_terraform"
    image_id  = "ami-0123b531fc646552f" #Ubuntu Server 18.04 LTS (HVM)"
    instance_type = "t2.micro"
    key_name   = "newkeypair"
    
	autoscalename = "AutoScalingGroup"
    autoscalemin_size =  2
    autoscalemax_size =  4
    autoscalehealth_check_grace_period =  200
    autoscalehealth_check_type =  "EC2"
    autoscaledesired_capacity =  2
    autoscaleforce_delete = true
	user_data = "install_apache1.sh"

database_details = {
    #Database storage is 5 
	#skip_final_snapshot = yes
    allocated_storage  = 5
    storage_type  = "gp2"
    engine  = "mysql"
    engine_version  = "5.7"
    instance_class  = "db.t2.micro"
    dbname  = "testdatabase"
    username  = "testdatabase"
    password  = "testdatabase"
    parameter_group_name = "default.mysql5.7"
    # Storgae will be extended upto 7
    max_allocated_storage = 7
	deletion_protection = false
	#skip_final_snapshot = yes
}