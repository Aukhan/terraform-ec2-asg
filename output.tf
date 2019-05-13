# Let's view the IP our EC2 was assigned
output "alb_dns_name" {
  value = "${aws_alb.terraform_alb.dns_name}"
}
