module "ec2" {
  source = "../"
  aws_region = "${var.aws_region}"
  subnet_private_1a_id = "SUBNET ID"
  subnet_private_1b_id = "SUBNET ID"
  subnet_public_1a_id = "SUBNET ID"
  subnet_public_1b_id = "SUBNET ID"
  subnet_private_1a_cidr = "10.0.0.1/24"
  subnet_private_1b_cidr = "10.0.0.2/24"
  subnet_public_1a_cidr = "10.1.0.1/24"
  subnet_public_1b_cidr = "10.1.0.2/24"  
  vpc_id = "VPC ID"
  jump_host_allowed_cidr_list = ["172.20.0.1/24"]
  aws_key_name = "${var.aws_key_name}"
  application_allowed_cidr_list = ["172.20.0.2/24"]
}