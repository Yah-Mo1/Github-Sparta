# **Terraform 2-Tier Architecture: Database VM Setup**

## **Overview**

This configuration sets up the **Database Virtual Machine (VM)** as part of a **2-tier architecture** on **Azure**, using **Terraform**. The **data sources** fetch existing infrastructure details, and **resources** create the required components.

## **1️⃣ Define Variables**

We define a **variable** for the **DB VM name prefix**, which ensures consistent naming across resources.

```hcl
variable "tech501-yahya-db-prefix" {
  default = "tech501-yahya-2-tier"
}
```

- This **prefix** is used to dynamically name resources like the **Network Interface (NIC)** and **VM**.

---

## **2️⃣ Fetch Existing Resource Group**

We retrieve an **existing Azure Resource Group** (`tech501`), ensuring all resources are deployed within this group.

```hcl
data "azurerm_resource_group" "tech501-yahya-rg" {
  name = "tech501"
}
```

- This avoids creating a new resource group and ensures that all infrastructure remains within a controlled scope.

---

## **3️⃣ Get Virtual Network & Subnet Information**

We **fetch an existing Virtual Network (VNet)** and a **private subnet** to attach our **Database VM**.

```hcl
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  resource_group_name = data.azurerm_resource_group.tech501-yahya-rg.name
}

data "azurerm_subnet" "tech501-yahya-private-subnet" {
  name                 = "private-subnet"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.tech501-yahya-rg.name
}
```

- **VNet**: The network where the DB VM will reside.
- **Subnet**: A **private subnet** ensures the database is **not directly accessible** from the internet.

---

## **4️⃣ Create the Network Interface for the DB VM**

We define a **Network Interface Card (NIC)** to enable communication between the **DB VM** and the private network.

```hcl
resource "azurerm_network_interface" "db-Nic" {
  name                = "${var.tech501-yahya-db-prefix}-nic"
  location            = data.azurerm_resource_group.tech501-yahya-rg.location
  resource_group_name = data.azurerm_resource_group.tech501-yahya-rg.name

  ip_configuration {
    name                          = "db-NIC-Ip"
    subnet_id                     = data.azurerm_subnet.tech501-yahya-private-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
```

- The NIC is assigned a **dynamically allocated private IP** inside the private subnet.
- This ensures **secure, internal communication** with the **App VM**.

---

## **5️⃣ Retrieve SSH Key for Secure Access**

We fetch the **existing SSH public key** to securely authenticate into the DB VM.

```hcl
data "azurerm_ssh_public_key" "ssh-key" {
  name                = "tech-501-yahya-az-key"
  resource_group_name = "tech501"
}
```

- This allows **password-less authentication** for secure access.

---

## **6️⃣ Use a Prebuilt Database Image**

We reference an **existing custom Azure Image** (`tech501-ramon-sparta-app-ready-to-run-db`) to deploy the database.

```hcl
data "azurerm_image" "tech501-yahya-sparta-db-img" {
  name                = "tech501-ramon-sparta-app-ready-to-run-db"
  resource_group_name = data.azurerm_resource_group.tech501-yahya-rg.name
}
```

- Using a **prebuilt image** speeds up deployment by avoiding manual database setup.

---

## **7️⃣ Deploy the Database Virtual Machine**

We now create the **DB VM** using all the **networking, security, and storage configurations**.

```hcl
resource "azurerm_virtual_machine" "tech501-yahya-terraform-db-vm" {
  name                          = "${var.tech501-yahya-db-prefix}-db-vm"
  location                      = data.azurerm_resource_group.tech501-yahya-rg.location
  resource_group_name           = data.azurerm_resource_group.tech501-yahya-rg.name
  size                          = "Standard_B1s"
  admin_username                = "adminuser"
  network_interface_ids         = [azurerm_network_interface.db-Nic.id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("/Users/yahmoham1/.sshkey/tech501-yahya-az-key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = "/subscriptions/cd36dfff-6e85-4164-b64e-b4078a773259/resourceGroups/tech501/providers/Microsoft.Compute/images/tech501-ramon-sparta-app-ready-to-run-db"

  tags = {
    owner = "yahya"
  }
}
```

- **VM Size:** `Standard_B1s` (small, cost-efficient).
- **Network Interface:** Connects to the **private subnet**.
- **Auto-delete disks on termination:** Cleans up storage when VM is destroyed.

---

## **8️⃣ Attach the Prebuilt Image to the VM**

We use the **custom database image** to create the VM.

```hcl
  storage_image_reference {
    id = data.azurerm_image.tech501-yahya-sparta-db-img.id
  }
```

- This ensures the database VM is **preconfigured and ready to use**.

---

## **9️⃣ Configure OS Disk for Storage**

We define the **OS disk** for the DB VM.

```hcl
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
```

- **Standard_LRS (Locally Redundant Storage)** is used for cost efficiency.

---

## **🔟 Linux OS Configuration**

We disable password authentication for security.

```hcl
  os_profile_linux_config {
    disable_password_authentication = true
  }
```

- This means users **must use an SSH key** to access the VM.

---

## **🔹 Tagging for Resource Management**

Finally, we add a **tag** to track the owner.

```hcl
  tags = {
    owner = "yahya"
  }
}
```

- **Tags** help with **cost tracking, organization, and filtering resources**.

---

## **Terraform Workflow**

### **1️⃣ Initialize Terraform**

```sh
terraform init
```

- Downloads required **providers and modules**.

### **2️⃣ Validate Configuration**

```sh
terraform validate
```

- Ensures syntax and logic are correct.

### **3️⃣ Plan Deployment**

```sh
terraform plan
```

- Shows what Terraform **will create or update**.

### **4️⃣ Apply Deployment**

```sh
terraform apply -auto-approve
```

- Deploys the **Database VM** and its dependencies.

### **5️⃣ Verify Resources in Azure**

Check in **Azure Portal** or use CLI:

```sh
az vm list -d -o table
```

- Lists deployed VMs.

---

## **Conclusion**

This Terraform configuration sets up a **secure Database Virtual Machine** with:
✅ A **private subnet** for secure communication  
✅ A **custom database image** for quick deployment  
✅ A **network interface** for connectivity  
✅ **SSH key-based authentication** for security

This is the **first part of a 2-tier architecture**, where the **App VM** (frontend) will later communicate with this **DB VM**.
