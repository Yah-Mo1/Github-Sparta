**Cloud Concepts**

**What is Cloud Computing?**

- **Definition:**  
  Cloud computing refers to the use of remote servers managed by a central authority to deliver services over the internet. These services are accessible from anywhere.

**Core Components of the Cloud**

- **Virtual Machines (VMs):** Virtualized resources that allow applications to run in isolated environments.
- **Virtual Network (VNet):** A secure network layer that connects cloud resources.
- **Databases (DBs):** Systems for storing, organizing, and retrieving data.
- **Cloud Storage:** Services like AWS S3 or Azure Blob Storage used to store data in the cloud.

**Key Principle:**  
Cloud platforms offer scalable resources, providing flexibility and efficiency in managing infrastructure and applications.

---

**Cloud Service Models**

**On-Premises vs Cloud Computing**

- **On-Premises:** You are responsible for managing the entire IT stack—hardware, software, and data.
- **Cloud Service Models:**
  - **IaaS (Infrastructure as a Service):** You manage applications and data, while the cloud provider handles the underlying infrastructure.
  - **PaaS (Platform as a Service):** The cloud provider manages most of the infrastructure, allowing you to focus on building and deploying applications.
  - **SaaS (Software as a Service):** The provider handles everything, and you simply use the software for your needs.

**Responsibility Shift:**  
As you transition from on-premises to SaaS, your responsibility decreases, and the cloud provider assumes more of the management and maintenance work.

---

**Planning and Creating a Virtual Network (VNet) in Azure**

**Steps to Plan a VNet:**

1. **Choose a VNet Name:** For example, `tech501-ramon-2-subnet-vnet`.
2. **CIDR Block:** Determine the IP address range, such as `10.0.0.0/16` (allowing for approximately 65,000 IP addresses).
3. **Subnets:**
   - **Public Subnet:** Example range `10.0.2.0/24` (provides 256 IPs).
   - **Private Subnet:** Example range `10.0.3.0/24` (also 256 IPs).

**Creating the VNet:**

1. **Project Details:** Select the appropriate subscription and resource group.
2. **VNet Configuration:** Set the VNet name and choose a region for deployment.
3. **IP Addressing:** Define the IP address space.
4. **Tagging:** Optionally, add metadata like `owner: Haashim`.

**Final Steps:**

- Review the configuration and create the VNet.
- Set up the necessary subnets and assign resources.

---

**Generating an RSA Key Pair**

**What is an RSA Key Pair?**  
An RSA key pair is a set of cryptographic keys used for secure communication. It consists of:

- **Private Key:** Kept confidential and used to authenticate you.
- **Public Key:** Shared with others to enable secure access.

**How to Generate an RSA Key Pair:**

1. Open your terminal.
2. Run the following command to generate the key pair:

   ```bash
   ssh-keygen -t rsa -b 4096 -C "youremailaddress"
   ```
