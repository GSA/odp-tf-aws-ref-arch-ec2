variable "aws_region" {
  default = "us-east-1"
}




variable "subnet_private_1a_id" {
  description = "subnet 1 id"
}

variable "subnet_private_1b_id" {
  description = "subnet 2 id"
}

variable "subnet_public_1a_id" {
  description = "subnet 1 id for the load balancer"
}

variable "subnet_public_1b_id" {
  description = "subnet 2 id for the load balancer"
}

variable "vpc_id" {
    description = "vpc id"
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}

variable "instance_1_name" {
  default = "odp-ra-instance-1"
}

variable "instance_2_name" {
  default = "odp-ra-instance-2"
}

variable "subnet_private_1a_cidr" {
  description = "cidr block for first private subnet"
}

variable "subnet_private_1b_cidr" {
  description = "cidr block for second private subnet"
}

variable "vpc_cidr" {
  description = "cidr block vpc"
}

variable "jump_host_allowed_cidr" {
  description = "List of cidr blocks allowed to ssh into jump server"
}

variable "jump_server_subnet_id" {
  description = "subnet id to place jump server in"
}

variable "jump_server_name" {
  default = "jump-server"
}

variable "aws_key_name" {
  description = "aws ec2 key name used to authenticate onto jump server"
}

variable "tag_for_ami_name_jump" {
  default = ["Packer-Jump"]
}

variable "tag_for_ami_name_private" {
  default = ["Packer-Private"]
}

variable "application_allowed_cidr" {
  description = "List of CIDR blocks that have access to the load balancer"
}


