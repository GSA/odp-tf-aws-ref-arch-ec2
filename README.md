# Instances

This module creates three AWS instances: 
- Two private instances built from an AMI using [this](../../packer/packer-private.json) Packer file. They will host Nginx web servers and are only accesable from within the VPC. 
- One public instance built from an AMI using [this](../../packer/packer-jump.json) packer file. It is used as a jump server to access the private instances because the private servers are only accessable from within the VPC built by [this](../network) module.  

## Variables 
| Name | Description |
|--|--|
| subnet_private_1a_id | The subnet ID for the first private instance |
| subnet_private_1b_id | The subnet ID for the first second instance |
| subnet_public_1a_id | The first subnet ID to hook up to the load balancer |
| subnet_public_1b_id | The second subnet ID to hook up to the load balancer |
| vpc_id | The ID of the VPC |
| subnet_private_1a_cidr | The CIDR block of the subnet with the first private instance used to configure the load balancer security group |
| subnet_private_1b_cidr | The CIDR block of the subnet with the second private instance used to configure the load balancer security group |
| vpc_cidr | The CIDR block of the VPC |
| jump_host_allowed_cidr | The list of CIDR blocks to allow SSH access to the public instance |
| jump_server_subnet_id | The subnet ID to place the public instance |
| aws_key_name | The name of the AWS key pair used to authenticate into the three instances |
| tag_for_ami_name_ jump | An array of strings which represent the value to the tag `Name` for the AMI to be created for the jump server |
| tag_for_ami_name_private | An array of strings which represent the value to the tag `Name` for the AMI to be created for the private servers |
| application_allowed_cidr | An array of CIDR blocks that are allowed access to the load balancer | 

## Further Information

To learn more about EC2 Instances click [here](https://aws.amazon.com/ec2/).
