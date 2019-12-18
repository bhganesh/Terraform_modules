#Creating Application Load balancer
resource "aws_lb" "applicationLB" {

  name = var.AppLBname
  internal = var.AppLBinternal
  load_balancer_type = var.AppLBload_balancer_type
  
  #CHECK THIS LINE LATER, Need to create a seperate security group for load balancer
  #security_groups    = [aws_security_group.publicseccuritygroup.id]
    security_groups  = [var.public_security_id]
   # we got this public subnets from output file
   # we can use output variable publicsubnet_ids while using modules
   #subnets = aws_subnet.public_subnets.*.id
   #subnets = [var.subnets]
   subnets = var.public_subnets
   #subnets = [aws_subnet.public_subnets.*.id[0],aws_subnet.public_subnets.*.id[1]]
 
   #Split function 
   #split(aws_subnet.public_subnets,0,2)
    enable_deletion_protection = var.AppLBenable_deletion_protection

  tags = {
    Environment = var.AppLBEnvironment
	
  }
}


#creating target group for USER and DASHBOARD
resource "aws_lb_target_group" "targetport80" {
  count = length(var.targetport80)
  name     = lookup(var.targetport80[count.index],"port80_name")
  port     = lookup(var.targetport80[count.index],"port80_port")
  protocol =  lookup(var.targetport80[count.index],"port80_protocol")
  #vpc id is from output file
 # vpc_id   = aws_vpc.qavpc.id
  vpc_id = var.vpc_id
  /*
  tags = {
		Name= lookup(var.targetport80[count.index],"Name")
	} */
}
/*
resource "aws_lb_listener" "httplistnersuser" {
   count = length(var.httplistnersuser)
    load_balancer_arn = aws_lb.applicationLB.arn
  # load_balancer_arn = "${aws_lb.applicationLB.arn}"
 
  port   =  lookup(var.httplistnersuser[count.index],"httplistnersuser_port")
  protocol = lookup(var.httplistnersuser[count.index],"httplistnersuser_protocol")
  
  
  
  default_action {
    type = lookup(var.httplistnersuser[count.index],"httplistnersuser_type")
	
	# Need to check this with SIR
    target_group_arn = aws_lb_target_group.targetport80.*.arn[count.index]
  }
}
*/

resource "aws_lb_listener" "Listener80" {
  load_balancer_arn   = aws_lb.applicationLB.arn
  port                = 80
  protocol            = "HTTP"

  default_action {
    #type              = "forward"
    #target_group_arn  = aws_lb_target_group.HTTPGrp-User.arn
	
	type = "redirect"
	redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
	
  }
}

resource "aws_lb_listener" "Listener443" {
  load_balancer_arn = aws_lb.applicationLB.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
 # arn:aws:acm:ap-south-1:713942048904:certificate/f237ebaf-f31d-4a92-bdec-f612043d752f
  certificate_arn   = "arn:aws:acm:ap-south-1:713942048904:certificate/f237ebaf-f31d-4a92-bdec-f612043d752f"
  #certificate_arn   = "arn:aws:acm:ap-south-1:713942048904:certificate/cc2bfe7f-77dc-490c-bb79-15b27716c780"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetport80[1].arn
  }
}
/*

#Attach target groups to instances , Both the below and this functions will add two instances for Target Groups
resource "aws_lb_target_group_attachment" "targetport80attach" {
  count = length(var.targetport80)
  target_group_arn = aws_lb_target_group.targetport80.*.arn[count.index]
  target_id  = var.privateinstance_id[0]
  port   = 80
}
#Attach target groups to instances , Both the above and this functions will add two instances for Target Groups
resource "aws_lb_target_group_attachment" "targetport80attach1" {
  count = length(var.targetport80)
  target_group_arn = aws_lb_target_group.targetport80.*.arn[count.index]
  target_id  = var.privateinstance_id[1]
  port   = 80
}
*/

#mention the rules for listners
resource "aws_lb_listener_rule" "http80" {
 count = length(var.targetport80)
  listener_arn = aws_lb_listener.Listener443.arn
  
  action {
    type = lookup(var.http80[count.index],"http80type")
    target_group_arn =  aws_lb_target_group.targetport80.*.arn[count.index]
  }

  condition {
    field  = lookup(var.http80[count.index],"http80field")
	values = [lookup(var.http80[count.index],"http80values")]
  }
}
