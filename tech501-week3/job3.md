# **Jenkins Job 3: Continuous Deployment to AWS EC2**

## **Overview**

This document describes how to configure and execute **Job 3** in Jenkins to automate the deployment of an updated application from Jenkins to an AWS EC2 instance.

## **Prerequisites**

Before running Job 3, ensure the following requirements are met:

- **An AWS EC2 instance is running** (Ubuntu 22.04 for Node.js 20 or Java 17, Ubuntu 18.04 for Node.js 12).
- **Jenkins server has SSH access** to the EC2 instance.
- **A valid SSH key (.pem file) is added to Jenkins** for authentication.
- **Security Group (SG) allows SSH (port 22) from Jenkins' IP**.
- **All necessary dependencies are installed on EC2** (Node.js, NPM, PM2, etc.).
- **Do not git clone the main branch directly into production.**

---

## **Deployment Steps in Jenkins Job 3**

1. Configure Discard old builds and ensure project repo is added under github project
   ![alt text](<Screenshot 2025-02-10 at 15.58.38.png>)

2. Add your ssh repository url as well as your github jenkins private key under source code management
   ![alt text](<Screenshot 2025-02-10 at 15.58.25.png>)

3. enable build trigger and add job2 as projects to watch
   also check ssh agent box and add your ec2 instance pem file
   ![alt text](<Screenshot 2025-02-10 at 15.58.16.png>)

4. Add your bash script to the build steps
   ![alt text](<Screenshot 2025-02-10 at 15.58.08.png>)

## Deployment Script Breakdown

This script deploys a Node.js application to an EC2 instance, installs dependencies, and restarts the necessary services.

### Step 1: Copy the Application Files to the Server

```sh
scp -o StrictHostKeyChecking=no -r nodejs20-sparta-test-app/app ec2-18-201-166-152.eu-west-1.compute.amazonaws.com:/home/ubuntu
```

Breakdown:
scp: Secure copy command for transferring files over SSH.
-o StrictHostKeyChecking=no: Disables host key verification to avoid SSH confirmation prompts.
-r: Recursively copies the entire app directory.
nodejs20-sparta-test-app/app: The source directory on your local machine.
ec2-18-201-166-152.eu-west-1.compute.amazonaws.com:/home/ubuntu: Destination on the remote EC2 server.

```ssh ec2-18-201-166-152.eu-west-1.compute.amazonaws.com << 'EOF'
cd app
sudo systemctl restart nginx
npm install
pm2 stop app.js
pm2 start app.js
EOF
```

Breakdown:
ssh ec2-18-201-166-152.eu-west-1.compute.amazonaws.com: Connects to the remote EC2 instance.
<< 'EOF' ... EOF: Sends multiple commands to the remote server in a single SSH session.
Inside the SSH Session:
cd app → Navigate to the application directory.
sudo systemctl restart nginx → Restart the Nginx web server to apply any configuration changes.
npm install → Install/update project dependencies.
pm2 stop app.js → Stop the running application process (if already running).
pm2 start app.js → Start the application using PM2 process manager.
