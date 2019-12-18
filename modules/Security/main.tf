resource "aws_security_group" "publicseccuritygroup" {
  name        = var.publicseccuritygroup_name
  description = var.publicseccuritydescription
 vpc_id = var.vpc_id 
/* Here we can connect to public instance from only ssh */
  ingress {
    from_port   = var.psfrom_port
    to_port     = var.psto_port
    protocol    = var.psprotocol
   cidr_blocks = [var.CIDR_ZEROBLOCKS]
	
  }
 ingress {
    from_port   = var.ps2from_port
    to_port     = var.ps2to_port
    protocol    = var.ps2protocol
    cidr_blocks = [var.CIDR_ZEROBLOCKS]
  }
  
  ingress {
	  # TLS (change to whatever ports you need)
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      # Please restrict your ingress to only necessary IPs and ports.
      # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
      cidr_blocks = ["0.0.0.0/0"] # add your IP address here
	}
  
  egress {
    from_port       =  var.egresfrom_port
    to_port         =  var.egresto_port
    protocol        =  var.egresprotocol
    cidr_blocks     =  [var.CIDR_ZEROBLOCKS]
  }
}