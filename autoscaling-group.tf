# Create a new EC2 launch configuration to be used with the autoscaling group.
resource "aws_launch_configuration" "terraform_launch_config" {
  name_prefix                 = "terraform-test-web-instance"
  image_id                    = "${var.aws_ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.terraform_sg_ec2.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("provision-ec2.sh")}"

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "20"
    delete_on_termination = true
  }
}

# Create the autoscaling group.
resource "aws_autoscaling_group" "terraform_autoscaling_group" {
  launch_configuration = "${aws_launch_configuration.terraform_launch_config.id}"
  min_size             = "2"
  max_size             = "4"
  desired_capacity     = "2"
  target_group_arns    = ["${aws_alb_target_group.terraform_alb_group.arn}"]

  vpc_zone_identifier = [
    "${aws_subnet.terraform_cluster_subnet_1.id}",
    "${aws_subnet.terraform_cluster_subnet_1.id}",
  ]

  tag {
    key                 = "Name"
    value               = "terraform-test-autoscaling-group"
    propagate_at_launch = true
  }
}
