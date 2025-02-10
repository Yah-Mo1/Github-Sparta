# Deploying a Two-Tier Architecture on AWS

## Setting Up the AWS Key Pair

Start by creating an AWS key pair, associating it with your instance, and downloading the `.pem` file through the AWS Console under **"Launch instance"**.

- Ensure that the AWS region is set to **Ireland**.

If needed, adjust the private key file's permissions:

```bash
chmod 400 /path/to/your-key-pair.pem
```

Replace `/path/to/your-key-pair.pem` with the actual path to your key file (e.g., `~/.ssh`).

To connect to your instance via SSH, use its **Public DNS**:

```bash
ssh -i "tech501-yahya-aws-key.pem" ubuntu@<your-ec2-public-ip>
```

When prompted, accept the SSH key fingerprint by typing **yes**.

Alternatively, you can create the key pair directly from the console:

```bash
ssh-keygen -t rsa -b 4096 -C <your-email>
```

---

## Creating the Database Virtual Machine

### VM Configuration:

- **Name**: `tech501-yahya-sparta-app-db-vm`
- **Image**: `Ubuntu 22.04 LTS`
- **Instance Type**: `t3.micro`
- **Key Pair**: `tech501-yahya-aws-key`

### Network Settings:

- **VPC**: `default`
- **Subnet**: `DevOpsStudent default 1c` (or `no preference`)
- **Public IP**: Disabled

### Security Group Configuration:

- **Group Name**: `tech501-yahya-sparta-app-db-nsg`
- **Description**: `Allow MongoDB access`

#### Inbound Rules:

- **SSH (Port 22)**: Allows remote access from anywhere.
- **MongoDB (Port 27017)**: Restricted to the **App VM’s Private IP**.

To SSH into the database VM:

```bash
ssh -i tech501-yahya-aws-key.pem ubuntu@<db_vm_public_ip>
```

---

## Setting Up MongoDB on the Database VM

Run the following script to install and configure MongoDB:

```bash
#!/bin/bash
# Install MongoDB on Ubuntu 22.04

sudo apt update && sudo apt upgrade -y
sudo apt install gnupg curl -y

# Add MongoDB repository and key
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Install MongoDB
sudo apt update
sudo apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6

# Enable and start MongoDB
sudo systemctl enable mongod
sudo systemctl start mongod

# Modify MongoDB bind IP to allow external connections (for testing only)
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
sudo systemctl restart mongod
```

---

## Creating the Application Virtual Machine

### VM Configuration:

- **Name**: `tech501-yahya-sparta-app-vm`
- **Image**: `Ubuntu 22.04 LTS`
- **Instance Type**: `t3.micro`
- **Key Pair**: `tech501-yahya-aws-key`

### Network Settings:

- **VPC**: `default`
- **Subnet**: `DevOpsStudent default 1c` (or `no preference`)
- **Public IP**: Enabled

### Security Group Configuration:

- **Group Name**: `tech501-yahya-sparta-app-nsg`
- **Description**: `Allow HTTP and SSH access`

#### Inbound Rules:

- **SSH (Port 22)**: Allows remote access from anywhere.
- **HTTP (Port 80)**: Allows access to the application.

To SSH into the application VM:

```bash
ssh -i tech501-yahya-aws-key.pem ubuntu@<app_vm_public_ip>
```

---

## Setting Up the Application on the App VM

The following script installs the required dependencies, configures the reverse proxy, and runs the application:

```bash
#!/bin/bash
# Install and configure application dependencies

# Update system packages
sudo apt update && sudo apt upgrade -y

# Install Nginx
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx

# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs

# Install PM2 process manager
sudo npm install -g pm2

# Clone the application repository
git clone <repo>

# Configure Nginx as a reverse proxy
sudo sed -i 's|try_files.*|proxy_pass http://127.0.0.1:3000;|' /etc/nginx/sites-available/default
sudo systemctl reload nginx

# Set up database connection
export DB_HOST=mongodb://<db_private_ip>:27017/posts

# Install application dependencies and seed the database
cd tech501-sparta-app
npm install

# Start the application with PM2
pm2 start app.js
```

Once completed, the application should be accessible via a web browser.

---

## Troubleshooting

If the `/posts` page does not load, it could indicate a connectivity issue between the database and application virtual machines.

To debug errors, check:

- MongoDB logs for potential database issues.
- Nginx logs for misconfiguration.
- The application logs for errors related to database connectivity.

For errors during `npm start`, inspect the logs for missing dependencies or incorrect environment variables.

---

This guide covers the setup of a two-tier architecture on AWS, deploying a database and an application on separate virtual machines with appropriate configurations. 🚀
