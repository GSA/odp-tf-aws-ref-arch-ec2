variable "aws_region" {
  type = string
  description = "Default region used by some modules"
  default = "us-east-1"
}

variable "subnet_private_1a_id" {
  description = "Subnet ID for EC2 instance in AZ 1a"
}

variable "subnet_private_1b_id" {
  description = "Subnet ID for EC2 instance in AZ 1a"
}

variable "subnet_private_1a_cidr" {
  description = "cidr block for first private subnet"
}

variable "subnet_private_1b_cidr" {
  description = "cidr block for second private subnet"
}

variable "subnet_public_1a_id" {
  description = "Subnet ID for ALB in AZ 1a"
}

variable "subnet_public_1b_id" {
  description = "Subnet ID for ALB in AZ 1b"
}


variable "subnet_public_1a_cidr" {
  description = "cidr block for first private subnet"
}

variable "subnet_public_1b_cidr" {
  description = "cidr block for second private subnet"
}


variable "vpc_id" {
    description = "ID of the VPC "
}


variable "aws_region" {
  default = "us-east-1"
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

variable "jump_host_allowed_cidr" {
  description = "cidr block allowed to ssh to jump host"
  type = list
  default = ["159.142.0.0/16"]
}

variable "application_allowed_cidr" {
  description = "cidr block allowed to reach ALB on port 80"
  type = list
  default     = ["159.142.0.0/16"]
}










