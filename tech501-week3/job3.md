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
