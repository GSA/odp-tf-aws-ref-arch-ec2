
resource "aws_security_group" "web_server_sg" {
  description = "Webserver Security group"
  name   = "web_server_sg"
  vpc_id = var.vpc_id

  # SSH access from the VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.jump_server.private_ip}/32"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.lb_sg.id}"]
  }
}

resource "aws_security_group" "jump_host_sg" {
  description = "Jump server security group"
  name   = "jump_host_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.jump_host_allowed_cidr_list
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.subnet_private_1a_cidr}", "${var.subnet_private_1b_cidr}"]
  }
}

resource "aws_security_group" "lb_sg" {
  description = "Loadbalancer security group"
  name   = "lb_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.application_allowed_cidr_list
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.subnet_private_1a_cidr}", "${var.subnet_private_1b_cidr}"]
  }
}



#############################
# Create instances


# Jump host
resource "aws_instance" "jump_server" {
  ami                         = "${var.ami_id_jump}"
  associate_public_ip_address = "true"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${var.subnet_public_1a_id}"
  vpc_security_group_ids      = ["${aws_security_group.jump_host_sg.id}"]
  key_name                    = "${var.aws_key_name}"

  tags = {
    Name = "${var.jump_server_name}"
  }
}

# Application hosts

resource "aws_instance" "instance_1" {
  ami                    = "${var.ami_id_private}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_private_1a_id}"
  vpc_security_group_ids = ["${aws_security_group.web_server_sg.id}"]
  key_name               = "${var.aws_key_name}"

  tags = {
    Name = "${var.instance_1_name}"
  }
}

resource "aws_instance" "instance_2" {
  ami                    = "${var.ami_id_private}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_private_1b_id}"
  vpc_security_group_ids = ["${aws_security_group.web_server_sg.id}"]
  key_name               = "${var.aws_key_name}"

  tags = {
    Name = "${var.instance_2_name}"
  }
}


###############################
# Configure ALB

resource "aws_lb" "alb" {
  name               = "odp-ra-alb"
  internal           = false #tfsec:ignore:AWS005
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.lb_sg.id}"]
  subnets            = ["${var.subnet_private_1a_id}", "${var.subnet_private_1b_id}"] # direct to public subnets 

  # access_logs {
  #   bucket  = "${aws_s3_bucket.lb_logs.bucket}"
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  # tags = {
  #   Environment = "production"
  # }
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}


resource "aws_lb_target_group_attachment" "alb_attatchment_1" {
  target_group_arn = "${aws_lb_target_group.alb_target_group.arn}"
  target_id        = "${aws_instance.instance_1.id}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb_attatchment_2" {
  target_group_arn = "${aws_lb_target_group.alb_target_group.arn}"
  target_id        = "${aws_instance.instance_2.id}"
  port             = 80
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = 80
  protocol          = "HTTP" #tfsec:ignore:AWS004
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.alb_target_group.arn}"
  }
}
