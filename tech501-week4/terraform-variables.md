# 📌 Terraform Variables Documentation

## 🛠️ Introduction

This document explains how variables are implemented in our Terraform configuration to make it more dynamic, reusable, and maintainable.

Instead of hardcoding values directly in the Terraform files, we use variables defined in `variables.tf`. This allows us to customize our infrastructure without modifying the main Terraform scripts.

---

## 📂 Files Structure

```plaintext
.
├── main.tf           # Terraform configuration for EC2 & Security Group
├── variables.tf      # Defines Terraform variables
├── terraform.tfvars  # (Optional) Overrides default variable values
├── outputs.tf        # (Optional) Defines outputs for useful values
📜 How Variables are Implemented
1️⃣ Defining Variables (variables.tf)
All configurable parameters are defined in variables.tf.

For example, here’s how we define the AMI ID:

hcl
Copy
Edit
variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
  default     = "ami-0c1c30571d2dae5c9"
}
This makes the AMI dynamic, so we can change it without modifying main.tf.
If no value is provided, it defaults to "ami-0c1c30571d2dae5c9".
2️⃣ Using Variables in main.tf
Instead of hardcoding values, we reference variables in main.tf.

For example:

hcl
Copy
Edit
resource "aws_instance" "app_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.tech257_sg.id]

  tags = {
    Name = var.instance_name
  }
}
Here, var.ami_id dynamically pulls the AMI value from variables.tf.
3️⃣ Using Variables for Security Groups
We use a list variable to define allowed ports dynamically:

hcl
Copy
Edit
variable "allowed_ports" {
  description = "List of allowed inbound ports"
  type        = list(number)
  default     = [22, 3000, 80]
}
Instead of hardcoding each port in the security group, we loop through allowed_ports:

hcl
Copy
Edit
dynamic "ingress" {
  for_each = var.allowed_ports
  content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
This allows us to easily modify the list of allowed ports by changing allowed_ports in variables.tf or terraform.tfvars.

📌 Overriding Variables (terraform.tfvars)
If we want to override the default values, we can create a terraform.tfvars file:

hcl
Copy
Edit
ami_id         = "ami-1234567890abcdef"
instance_type  = "t3.medium"
key_name       = "new-keypair"
instance_name  = "custom-instance"
allowed_ports  = [22, 443, 8080]
To apply these values, run:

sh
Copy
Edit
terraform apply -var-file="terraform.tfvars"
🎯 Benefits of Using Variables
✔ Flexibility – We can deploy different configurations without modifying the code
✔ Reusability – The same Terraform script can be used for multiple environments (dev, staging, prod)
✔ Simplified Management – Instead of editing main.tf, we just update variables.tf or terraform.tfvars
```
