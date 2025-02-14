# **Terraform 2-Tier Architecture: App VM Setup**

## **Overview**

This configuration sets up the **App Virtual Machine (VM)** as part of a **2-tier architecture** on **Azure**, using **Terraform**. The **data sources** fetch existing infrastructure details, and **resources** create the required components.

## **1️⃣ Define Variables**

We define a **variable** for the **App VM name prefix**, which ensures consistent naming across resources.

```hcl
variable "tech501-yahya-app-prefix" {
  default = "tech501-yahya-2-tier"
}
```

- This **prefix** is used to dynamically name resources like the **Network Interface (NIC)** and **VM**.

---

## **2️⃣ Fetch Virtual Network & Subnet Information**

We **fetch an existing Virtual Network (VNet)** and a **public subnet** to attach our **App VM**.

```hcl
data "azurerm_virtual_network" "tech501-yahya-vnet" {
  name                = var.vnet-name
  resource_group_name = data.azurerm_resource_group.tech501-yahya-rg.name
}

data "azurerm_subnet" "tech501-yahya-public-subnet" {
  name                 = "public-subnet"
  virtual_network_name = data.azurerm_virtual_network.tech501-yahya-vnet.name
  resource_group_name  = data.azurerm_resource_group.tech501-yahya-rg.name
}
```

- **VNet**: The network where the App VM will reside.
- **Subnet**: A **public subnet** ensures the App VM is **accessible from the internet**.

---

## **3️⃣ Create the Public IP for the App VM**

We define a **Public IP** for the **App VM**, allowing it to be **reachable from the internet**.

```hcl
resource "azurerm_public_ip" "tech501-yahya-sparta-public-ip" {
  name                = "${var.tech501-yahya-app-prefix}-public-ip"
  location            = data.azurerm_resource_group.tech501-yahya-rg.location
  resource_group_name = data.azurerm_resource_group.tech501-yahya-rg.name
  allocation_method   = "Dynamic"  # or "Static" if you require a fixed IP
  sku                 = "Basic"    # or "Standard" depending on your needs
}
```

- This **Dynamic Public IP** allows the App VM to have an internet-accessible IP address.

---

## **4️⃣ Create the Network Interface for the App VM**

We define a **Network Interface Card (NIC)** to enable communication between the **App VM** and the **public subnet**.

```hcl
resource "azurerm_network_interface" "app-NIC" {
  name                = "${var.tech501-yahya-app-prefix}-app-nic"
  location            = data.azurerm_resource_group.tech501-yahya-rg.location
  resource_group_name = data.azurerm_resource_group.tech501-yahya-rg.name

  ip_configuration {
    name                          = "app-NIC-Ip"
    subnet_id                     = data.azurerm_subnet.tech501-yahya-public-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tech501-yahya-sparta-public-ip.id
  }
}
```

- The **NIC** connects the App VM to the **public subnet**, with a **dynamic public IP**.

---

## **5️⃣ Configure Network Security Group (NSG)**

We create a **Network Security Group (NSG)** to define security rules for the App VM. This NSG allows **SSH** (port 22) and **HTTP** (port 80) traffic.

```hcl
resource "azurerm_network_security_group" "tech-501-yahya-nsg" {
  name                = "${var.tech501-yahya-app-prefix}-nsg"
  location            = data.azurerm_resource_group.tech501-yahya-rg.location
  resource_group_name = data.azurerm_resource_group.tech501-yahya-rg.name

  # Allow SSH (port 22)
  security_rule {
    name                       = "allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow HTTP (port 80)
  security_rule {
    name                       = "allow-HTTP"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
```

- This **NSG** ensures that the App VM can receive **SSH** and **HTTP** traffic.

---

## **6️⃣ Associate NSG with the App NIC**

We associate the **NSG** with the **App VM's NIC** to apply the security rules.

```hcl
resource "azurerm_network_interface_security_group_association" "tech-501-yahya-nsg-association" {
  network_interface_id      = azurerm_network_interface.app-NIC.id
  network_security_group_id = azurerm_network_security_group.tech-501-yahya-nsg.id
}
```

- This ensures that the **network security rules** are applied to the **App VM's NIC**.

---

## **7️⃣ Retrieve SSH Key for Secure Access**

We fetch the **existing SSH public key** to securely authenticate into the App VM.

```hcl
data "azurerm_ssh_public_key" "tech-501-yahya-az-key" {
  name                = "tech-501-yahya-az-key"
  resource_group_name = "tech501"
}
```

- This allows **password-less authentication** for secure access.

---

## **8️⃣ Deploy the App Virtual Machine**

We now create the **App VM**, specifying all networking, security, and storage configurations.

```hcl
resource "azurerm_linux_virtual_machine" "tech501-yahya-terraform-app-vm" {
  name                          = "${var.tech501-yahya-app-prefix}-app-vm"
  location                      = data.azurerm_resource_group.tech501-yahya-rg.location
  resource_group_name           = data.azurerm_resource_group.tech501-yahya-rg.name
  size                          = "Standard_B1s"
  admin_username                = "adminuser"
  network_interface_ids         = [azurerm_network_interface.app-NIC.id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("/Users/yahmoham1/.sshkey/tech501-yahya-az-key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  custom_data = base64encode("#!/bin/bash\ncd /repo/app\nexport DB_HOST=mongodb://10.0.3.4/posts\npm2 start app.js")

  tags = {
    owner = "yahya"
  }

  source_image_id = "/subscriptions/cd36dfff-6e85-4164-b64e-b4078a773259/resourceGroups/tech501/providers/Microsoft.Compute/images/tech501-ramon-sparta-test-app-ready-to-run-app"
}
```

- **VM Size:** `Standard_B1s` (small, cost-efficient).
- **Network Interface:** Connects to the **public subnet** with **public IP**.
- **Custom Data Script:** Starts the application (`app.js`) on deployment.
- **SSH Key Authentication:** Provides secure access.

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

- Deploys the **App VM** and its dependencies.

### **5️⃣ Verify Resources in Azure**

Check in **Azure Portal** or use CLI:

```sh
az vm list -d -o table
```

- Lists deployed VMs.

---

## **Conclusion**

This Terraform configuration sets up an **App Virtual Machine** with:
✅ A **public subnet** for internet accessibility  
✅ A **dynamic public IP** for external communication  
✅ A **custom data script** to start the application  
✅ **SSH key-based authentication** for security

## Final Results

## **Front Page**

![Front Page](Screenshot%202025-02-13%20at%2014.17.12.png)

## **Post Page**

![Post Page](Screenshot%202025-02-13%20at%2014.17.05.png)
