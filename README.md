Example to create an AWS VPC and two subnets with an Autoscaling Group hit by an Application Load Balancer. Creates two security groups for this infrastructure, one for the load balancer and the other for the Autoscaling Launch configuration with appropriate rules to allow SSH and HTTP in bound only. It expects that you already have a key generated in AWS and will ask for that key pair's name as a variable.

#### Credentials
- Expects a file named aws.credentials to be placed at the root
- The contents of the file should look like
```sh
[default]
aws_access_key_id=<access_key>
aws_secret_access_key=<secret_key>
```

#### Setup
Change any names if you have to and then run
```sh
terraform plan
```
If all looks good
```sh
terraform apply
```
#### Output
The Load balancer DNS Name will be output
```sh
alb_dns_name = x.x.x.x
```

Hit the DNS name in a browser to see the nginx default screen popup

### Teardown
```sh
terraform destroy
```
