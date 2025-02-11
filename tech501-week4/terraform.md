# Terraform: Infrastructure as Code (IaC)

## What is Terraform? What is it used for?

**Terraform** is an open-source **Infrastructure as Code (IaC)** tool developed by **HashiCorp**.  
It allows users to define, provision, and manage cloud infrastructure using a **declarative configuration language** called **HashiCorp Configuration Language (HCL)** or **JSON**.

Terraform is used for:

- Provisioning **cloud infrastructure** (e.g., virtual machines, networks, databases).
- Managing **Kubernetes clusters**.
- Automating **multi-cloud deployments**.
- Implementing **immutable infrastructure** best practices.

## Why use Terraform? The benefits?

Terraform provides several advantages, including:

- **Infrastructure as Code (IaC)** – Automates infrastructure management with code.
- **Declarative Approach** – Users define the desired state, and Terraform ensures the infrastructure matches it.
- **Multi-Cloud Support** – Works across **AWS, Azure, Google Cloud, Kubernetes**, and more.
- **State Management** – Uses a state file (`terraform.tfstate`) to track infrastructure changes.
- **Dependency Management** – Determines the correct order for provisioning resources.
- **Reusability** – Modules enable reusable infrastructure code.
- **Scalability** – Handles large infrastructure environments efficiently.

## Alternatives to Terraform

While Terraform is widely used, other **Infrastructure as Code (IaC)** tools include:

- **AWS CloudFormation** – AWS-native IaC tool.
- **Pulumi** – Uses general-purpose programming languages for IaC.
- **Ansible** – Configuration management with some provisioning capabilities.
- **Chef/Puppet** – Focuses on configuration automation rather than infrastructure provisioning.
- **Crossplane** – Kubernetes-native infrastructure management.

## Who is using Terraform in the industry?

Terraform is used by many organizations, including:

- **Tech Giants** – Google, Microsoft, AWS, Meta.
- **Financial Institutions** – JPMorgan Chase, Goldman Sachs.
- **Startups & Enterprises** – Netflix, Uber, Airbnb, Shopify.
- **Government & Healthcare** – NASA, US Government agencies.

Terraform is widely adopted across industries for **automating cloud infrastructure** at scale.

## In IaC, what is orchestration? How does Terraform act as an "orchestrator"?

**Orchestration** in Infrastructure as Code (IaC) refers to **automating the provisioning, configuration, and management of infrastructure resources**.

Terraform acts as an **orchestrator** by:

- **Determining dependencies** between resources and provisioning them in the correct order.
- **Handling resource updates** by comparing the desired state with the current state.
- **Destroying infrastructure** safely when no longer needed.
- **Managing multi-cloud and hybrid-cloud environments** seamlessly.

## Best practice: Supplying AWS credentials to Terraform

Terraform needs **AWS access** to manage infrastructure. The best practice for supplying credentials includes:

- **Use IAM roles with EC2 instances** (best security practice).
- **Use AWS SSO (Single Sign-On)** for authentication.
- **Use environment variables** (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`).
- **Use AWS credentials file** (`~/.aws/credentials`).
- **Use AWS CLI profiles** (`aws configure`).

### How should AWS credentials **never** be passed to Terraform?

❌ **Never store AWS credentials in Terraform configuration files (`.tf` files).**  
❌ **Avoid hardcoding credentials in scripts.**  
❌ **Do not commit credentials to version control (e.g., GitHub).**

## AWS Credentials Lookup Order (Precedence)

Terraform looks up AWS credentials in the following order (highest to lowest priority):

1. **Environment variables** (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`).
2. **AWS credentials file** (`~/.aws/credentials`).
3. **AWS CLI profile (`aws configure`)**.
4. **IAM Role (when running Terraform on an AWS EC2 instance with an IAM role attached).**

Terraform will use the first valid credentials it finds in the above order.

## Why use Terraform for different environments (e.g., production, testing, etc.)?

Using Terraform for **multiple environments** helps maintain consistency, security, and automation.

**Key reasons to use Terraform for different environments:**

- **Isolation** – Keeps production, staging, and testing environments separate.
- **Consistency** – Ensures that environments are configured identically.
- **Automation** – Reduces manual setup and human errors.
- **Rollback & Recovery** – Allows quick restoration of previous infrastructure states.

### Best practices for managing environments:

- Use **Terraform workspaces** for multiple environments.
- Define **separate state files** for each environment.
- Use **modules** to reuse infrastructure code across environments.
- Implement **version control (Git)** to track infrastructure changes.

By following these practices, teams can manage cloud resources more efficiently while minimizing risks.

---
