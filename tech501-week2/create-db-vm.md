# Deploying a Database VM

# Guide for Setting Up the Database Virtual Machine

## 1. VM Name

- Use a consistent naming convention: `tech501-yourname-sparta-app-db-vm`.
- Replace `yourname` with your actual name or identifier to ensure the VM name is unique.

---

## 2. Image

- Use the **Ubuntu 22.04 LTS** image:
  - Ubuntu 22.04 LTS (Long-Term Support) provides a stable and secure operating system, suitable for server and database workloads.
  - Ensure that the image is selected during the VM creation process in your cloud platform (e.g., Azure, AWS, Google Cloud).

---

## 3. VM Size

- Choose the **same size as usual**, which should match your organization's standard configuration.
  - Example: A VM with **2 vCPUs and 4 GB RAM** or any predefined size commonly used for your environment.
- Ensure the size is sufficient for running a database application while leaving room for scalability.

---

## 4. Network Security Group (NSG)

- Configure the NSG to **allow SSH** for remote access:
  - **Rule Details**:
    - **Priority**: 100 (lower values have higher priority)
    - **Port**: 22
    - **Protocol**: TCP
    - **Source**: Any (or limit to your IP address/range for better security)
    - **Action**: Allow
- Verify the NSG is attached to the VM’s network interface.

---

## 5. Public IP

- **Enable Public IP** to allow remote management and database access if required:
  - Ensure the public IP is assigned to the VM.
  - Configure a DNS name for the public IP (optional but useful for easy access).
  - If this VM will be part of a secure network with no external access, ensure the public IP is restricted or only temporarily enabled for initial setup.

---

## 6. Virtual Network (VNet)

- Assign the VM to the **2-net** Virtual Network:
  - Ensure the VNet is pre-configured or create it if necessary.
  - Use the **private-subnet** within the VNet to isolate the database VM from other services.
  - This enhances security by keeping the VM in a controlled private network space.
- Ensure routing and access between subnets are configured properly (e.g., if the application server VM resides on a different subnet).

---

## 7. Post-Deployment Configuration

Once the VM is created and running, follow these steps:

### a. Login to the VM:

- Use SSH to connect:
  ```bash
  ssh username@<VM_Public_IP>
  ```

Here’s the markdown version for your README.md file:

markdown
Copy
Edit

# Guide for Setting Up the Database Virtual Machine

## 1. VM Name

- Use a consistent naming convention: `tech501-yourname-sparta-app-db-vm`.
- Replace `yourname` with your actual name or identifier to ensure the VM name is unique.

---

## 2. Image

- Use the **Ubuntu 22.04 LTS** image:
  - Ubuntu 22.04 LTS (Long-Term Support) provides a stable and secure operating system, suitable for server and database workloads.
  - Ensure that the image is selected during the VM creation process in your cloud platform (e.g., Azure, AWS, Google Cloud).

---

## 3. VM Size

- Choose the **same size as usual**, which should match your organization's standard configuration.
  - Example: A VM with **2 vCPUs and 4 GB RAM** or any predefined size commonly used for your environment.
- Ensure the size is sufficient for running a database application while leaving room for scalability.

---

## 4. Network Security Group (NSG)

- Configure the NSG to **allow SSH** for remote access:
  - **Rule Details**:
    - **Priority**: 100 (lower values have higher priority)
    - **Port**: 22
    - **Protocol**: TCP
    - **Source**: Any (or limit to your IP address/range for better security)
    - **Action**: Allow
- Verify the NSG is attached to the VM’s network interface.

---

## 5. Public IP

- **Enable Public IP** to allow remote management and database access if required:
  - Ensure the public IP is assigned to the VM.
  - Configure a DNS name for the public IP (optional but useful for easy access).
  - If this VM will be part of a secure network with no external access, ensure the public IP is restricted or only temporarily enabled for initial setup.

---

## 6. Virtual Network (VNet)

- Assign the VM to the **2-net** Virtual Network:
  - Ensure the VNet is pre-configured or create it if necessary.
  - Use the **private-subnet** within the VNet to isolate the database VM from other services.
  - This enhances security by keeping the VM in a controlled private network space.
- Ensure routing and access between subnets are configured properly (e.g., if the application server VM resides on a different subnet).

---

## 7. Post-Deployment Configuration

Once the VM is created and running, follow these steps:

### a. Login to the VM:

- Use SSH to connect:
  ```bash
  ssh username@<VM_Public_IP>
  Replace <VM_Public_IP> with the actual public IP of the VM.
  ```

### b. Update & Upgrade:

- Run the following commands to ensure the VM has the latest security patches and updates:
  bash
  Copy
  Edit
  sudo apt update && sudo apt upgrade -y

8. **Create a DB Image and a DB Virtual machine from the image**

   - Use the `waagent` command to prepare the VM:
     ```bash
     sudo waagent -deprovision+user
     ```

9. **Create the Image**

   - In Azure, create an image with the name:  
     `tech501-yahya-sparta-db-ready-to-run-img`
   - If you receive a "Plan information" error, delete the VM and create a new one using the image:  
     `yahya-official-ubuntu2204-clean-image` in the `tech501` resource group.

10. **Delete the DB VM**
    - Stop the Current Azure DB and Delete it
    - Use the current new image to Recreate a new DB VM
    - Once created, log into it using SSH
