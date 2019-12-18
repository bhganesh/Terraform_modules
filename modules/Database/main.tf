# This function is to assign the subnet ids 
resource "aws_db_subnet_group" "mysubnetgroupname" {
  name       = "main"
  subnet_ids =  var.public_subnets_database

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "MyDatabase"{
    #Database storage is 5 
    allocated_storage = var.database_details.allocated_storage
   
    #This will be useful while destroying the Database
    #skip_final_snapshot =   var.database_details.skip_final_snapshot
    skip_final_snapshot = true
    storage_type  =   var.database_details.storage_type
    engine  =   var.database_details.engine
    instance_class =  var.database_details.instance_class
    name   =   var.database_details.dbname
    username  =  var.database_details.username
    password  =   var.database_details.password
    parameter_group_name =   var.database_details.parameter_group_name
    
    # Storgae will be extended upto 7
    max_allocated_storage =   var.database_details.max_allocated_storage
    
    #delete protection should be disable
    deletion_protection =   var.database_details.deletion_protection
    
    # go this value from "aws_db_subnet_group" "mysubnetgroupname"
    db_subnet_group_name = aws_db_subnet_group.mysubnetgroupname.id

}