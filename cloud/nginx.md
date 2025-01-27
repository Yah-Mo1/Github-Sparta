### **Setting Up an Nginx Web Server on Azure**

#### **What is Nginx?**

Nginx is a powerful, open-source web server used for serving websites, acting as a reverse proxy, or balancing server loads. It’s known for its high performance and scalability, making it a popular choice for hosting web applications.

#### **Why Use Azure for Nginx?**

Azure provides a cloud-based platform where you can create Virtual Machines (VMs) to host your web server. By running Nginx on an Azure VM, you can build, customize, and deploy web applications without the need for physical hardware. This setup is great for testing, personal projects, or hosting a live website.

---

### **Steps to Set Up and Customize Nginx on Azure**

#### **1. Update and Upgrade Packages**

Before installing new software, it’s important to ensure your system has the latest package information and updates. Run these commands:

- Refresh the package list: `sudo apt update`
- Install any available updates: `sudo apt upgrade -y`

#### **2. Install Nginx**

Install the Nginx web server using the following command:  
`sudo apt install nginx`

#### **3. Start and Manage the Nginx Service**

- Start Nginx: `sudo systemctl start nginx`
- Check if Nginx is running: `sudo systemctl status nginx`
- Enable it to start automatically when the VM boots: `sudo systemctl enable nginx`
