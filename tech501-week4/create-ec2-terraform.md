# Deploying an AWS EC2 Instance with Terraform

## **Prerequisites**

- Terraform installed ([Download Terraform](https://developer.hashicorp.com/terraform/downloads))
- AWS CLI installed and configured (`aws configure`)
- An existing AWS key pair

## **Terraform Configuration**

The following Terraform script creates an EC2 instance in AWS:

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_instance" {
  # which AMI ID
  ami = "ami-0c1c30571d2dae5c9"

  # which type of instance
  instance_type = "t3.micro"

  # that we want a public ip
  associate_public_ip_address = true

  # name the service/instance
  tags = {
    Name = "tech501-name-terraform-app"
  }
}

```
