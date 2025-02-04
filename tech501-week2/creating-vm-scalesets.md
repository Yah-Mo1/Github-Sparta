## What is a Virtual Machine Scale Set (VMSS)?

A **Virtual Machine Scale Set (VMSS)** in Azure is a cloud service that allows you to deploy and manage a group of identical, load-balanced virtual machines (VMs). It supports **automatic scaling** based on demand, ensuring high availability and efficient resource utilization. VMSS is ideal for handling workloads that require dynamic scaling, such as web applications, microservices, and distributed systems.

## Creating a Virtual Machine Scale Set in Azure Portal

To create a **Virtual Machine Scale Set** using the **Azure Portal**, follow these steps:

### 1. Navigate to the Azure Portal

Sign in to [Azure Portal](https://portal.azure.com) and navigate to **"Virtual Machine Scale Sets"**, then click **"Create"**.

### 2. Configure Basic Settings

Fill in the required details such as:

- VMSS **Name**
- **Region**
- **Instance Size** (based on workload requirements)
- **Authentication Method** (Password or SSH Key)

Refer to the image below for guidance:  
![Basic Configuration](<Screenshot 2025-01-30 at 16.38.49.png>)

### 3. Configure Disk Settings

- Under the **Disk** section, set the disk type to **Standard SSD** for a balance between cost and performance.

### 4. Configure Networking

In the **Networking** section:

- Attach an existing or new **Virtual Network (VNet)**.
- Assign a **Public Subnet**.
- Configure **Network Security Groups (NSGs)** with inbound rules.
- Create and associate a **Load Balancer** with the VM Scale Set.

![Networking Configuration](<Screenshot 2025-01-30 at 16.40.20.png>)

### 5. Enable Health Monitoring & Auto Repair

- Navigate to the **Health** section.
- Enable **Application Health Monitoring** and **Auto Repair** for improved reliability.

![Health Monitoring](<Screenshot 2025-01-30 at 16.42.30.png>)

### 6. Add User Data for Automated Setup

- In the **Advanced** tab, check **User Data**.
- Copy and paste the **Bash script** (used earlier) into the **User Data** field to automate the startup of your **Node.js application**.

![User Data Configuration](<Screenshot 2025-01-30 at 16.43.08.png>)

### 7. Validate Configuration

- Ensure that **Validation** passes, indicating that the VMSS configuration is correct.

![Validation Success](<Screenshot 2025-01-30 at 16.43.29.png>)

### 8. Create the VM Scale Set

- Click **"Create"** to deploy the VM Scale Set.
- Once deployed, navigate to your **VM Scale Set** and **Load Balancer**.

### 9. Retrieve Load Balancer IP & Test Application

- Copy the **Public IP Address** assigned to the **Load Balancer**.
- Open a browser and enter the full URL, or copy the ip address into your search engine

- Verify that the **application is running correctly**.

![Application Verification](<Screenshot 2025-01-30 at 16.46.47.png>)
