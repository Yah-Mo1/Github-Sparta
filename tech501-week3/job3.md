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

![alt text](<Screenshot 2025-02-07 at 17.02.24.png>)

![alt text](<Screenshot 2025-02-07 at 16.57.29.png>)

![alt text](<Screenshot 2025-02-07 at 15.06.25.png>)

![alt text](<Screenshot 2025-02-07 at 15.06.18.png>)

### **1. Define EC2 Connection Variables**

Set up environment variables for **user, host IP, and application directory**:

```bash
EC2_USER="ubuntu"
EC2_HOST="3.255.218.199"
APP_DIR="/tech501-sparta-app-cicd/nodejs20-sparta-test-app/app"
2. Ensure the Application Directory Exists on EC2
Before copying files, make sure the target directory exists:

bash
Copy
Edit
ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST "mkdir -p $APP_DIR"
3. Copy Updated Application Files to EC2
Use scp to transfer updated files from Jenkins workspace to the EC2 instance:

bash
Copy
Edit
scp -o StrictHostKeyChecking=no -r app/* $EC2_USER@$EC2_HOST:$APP_DIR/
4. SSH into EC2 and Restart the Application
After copying, log into EC2 and restart the application:

bash
Copy
Edit
ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST << 'EOF'
cd /tech501-sparta-app-cicd/nodejs20-sparta-test-app/app
npm install  # Ensure dependencies are installed
pm2 restart app || pm2 start app.js --name "app"
EOF
Summary of the Deployment Process
Define EC2 Variables: Set SSH username, EC2 IP, and app directory path.


Ensure Target Directory Exists: Create the app directory on EC2 if it doesn't exist.
Copy Files to EC2: Securely transfer updated application files from Jenkins to EC2 using scp.
Deploy & Restart the App:
SSH into EC2.
Navigate to the application directory.
Run npm install to install/update dependencies.
Restart the app using pm2 restart, or start it if it's not running.
Expected Outcome
Once the job is executed in Jenkins:

The updated application files are copied to EC2.
Dependencies are installed/updated.
The application restarts automatically with pm2.
🚀 Purpose: Automates the deployment process by transferring, updating, and restarting the app on AWS EC2 directly from Jenkins.

Troubleshooting & Debugging
Issue	Possible Cause	Solution
Permission denied (publickey)	Incorrect SSH key or wrong permissions	Ensure .pem file is added in Jenkins & correct permissions (chmod 600)
Cannot connect to EC2	Security Group not configured properly	Allow SSH access from Jenkins' IP in EC2 Security Group
npm install fails	Missing Node.js/NPM on EC2	Install Node.js & NPM: sudo apt update && sudo apt install -y nodejs npm
pm2 command not found	PM2 is not installed globally	Run npm install -g pm2 before deploying
Next Steps

✅ Run Job 3 in Jenkins and verify deployment.
📸 Capture screenshots of the updated application homepage after deployment.
📌 Create a diagram explaining the CI/CD pipeline from Jenkins to EC2.
```
