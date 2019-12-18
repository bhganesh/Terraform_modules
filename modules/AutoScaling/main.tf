resource "aws_launch_configuration" "as_conf" {
  name   = var.name
  #iam_instance_profile  = "My new Instance"
  #This associate_public_ip should be false
  associate_public_ip_address = "false"  
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name    = var.key_name
  #security_groups = [var.LoadBalSecurityGrpID]
   security_groups  = [var.public_security_id]
  #user_data                   = "./user-data/user-data-prv1.sh"
  user_data = file(var.user_data)
  lifecycle {
   create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bar" {
  name                 = var.autoscalename
  launch_configuration =  aws_launch_configuration.as_conf.name
  #we need to send Private subnets.
  vpc_zone_identifier =  var.private_subnets
  min_size             =  var.autoscalemin_size
  max_size             =  var.autoscalemax_size
  health_check_grace_period =  var.autoscalehealth_check_grace_period
  health_check_type =  var.autoscalehealth_check_type
  desired_capacity =  var.autoscaledesired_capacity
  force_delete =  var.autoscaleforce_delete


  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
count = length(var.targetgroup_arn)
autoscaling_group_name = aws_autoscaling_group.bar.id
alb_target_group_arn = var.targetgroup_arn[count.index]
}