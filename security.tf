resource "aws_security_group" "terraform_sg_ec2" {
  vpc_id      = "${aws_vpc.terraform_vpc.id}"
  name        = "Terraform Security Group - EC2 Instances"
  description = " Generated by Terraform - Security Group to contain all instances in the Auto SCaling Group"

  # Restrict inboud SSH traffic by IP address.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.allowed_cidr_blocks}"
  }

  # Allow ICMP echo requests.
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = "${var.allowed_cidr_blocks}"
  }

  # Restrict inbound HTTP traffic to the load balancer.
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.allowed_cidr_blocks}"
  }

  # Allow outbound internet access.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.allowed_cidr_blocks}"
  }

  tags {
    Name = "terraform-test-webservers-security-group"
  }
}

resource "aws_security_group" "terraform_sg_alb" {
  vpc_id      = "${aws_vpc.terraform_vpc.id}"
  name        = "Terraform Security Group - ALB"
  description = " Generated by Terraform - Security Group for Application Load Balancer"

  # Restrict inbound HTTP traffic to the load balancer.
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.allowed_cidr_blocks}"
  }

  # Restrict inbound HTTPS traffic to the load balancer.
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.allowed_cidr_blocks}"
  }

  # Allow outbound internet access.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.allowed_cidr_blocks}"
  }

  tags {
    Name = "terraform-test-webservers-security-group"
  }
}
