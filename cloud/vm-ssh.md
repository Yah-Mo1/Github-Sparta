# SSH Key Creation and Connecting to an Azure Virtual Machine

This document provides a step-by-step guide on creating SSH keys, setting up an Azure Virtual Machine (VM) using the key, and connecting to the VM securely. It also includes brief explanations of the components and resources involved.

## Prerequisites

- **Azure Account**: Ensure you have an active Azure account.
- **Command Line Interface (CLI)**: A terminal or command-line tool to create SSH keys and interact with Azure resources.
- **Azure CLI Installed**: Download and install the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) if you haven't already.

---

## Steps

### 1. Generate an SSH Key Locally

SSH keys are used for secure authentication without the need for passwords. Here's how to create an SSH key pair:

1. Open your terminal (Linux/Mac) or PowerShell (Windows).
2. Run the following command:
   ```bash
   ssh-keygen -t rsa -b 2048
   ```
3. Provide a file path to save the key (or press Enter to save it in the default location, e.g., `~/.ssh/id_rsa`).
4. Enter a passphrase (optional but recommended).

This will generate two files:

- **Public key**: `id_rsa.pub`
- **Private key**: `id_rsa`

> **Important**: Never share your private key.

### 2. Reference the SSH Key in Azure

Once you have the public key, you can use it while creating the VM in Azure.

#### Add the SSH Key to Azure VM Configuration:

1. Sign in to Azure:
   ```bash
   az login
   ```
2. Use the following command to create an Azure Virtual Machine, referencing your SSH public key:

   ```bash
   az vm create \
       --resource-group <Resource-Group-Name> \
       --name <VM-Name> \
       --image UbuntuLTS \
       --admin-username <Your-Username> \
       --ssh-key-value ~/.ssh/id_rsa.pub
   ```

   Replace the placeholders (`<Resource-Group-Name>`, `<VM-Name>`, `<Your-Username>`) with your desired values.

   - **`--resource-group`**: The Azure resource group where the VM will be created.
   - **`--name`**: The name of the VM.
   - **`--image`**: Specifies the OS image to use (e.g., Ubuntu).
   - **`--admin-username`**: The admin username for the VM.
   - **`--ssh-key-value`**: Path to the public SSH key you generated.

### 3. Connect to the Azure VM Using SSH

Once the VM is deployed, you can connect to it securely using your private key:

1. Locate the public IP address of the VM:

   ```bash
   az vm show \
       --resource-group <Resource-Group-Name> \
       --name <VM-Name> \
       --query publicIpAddress -o tsv
   ```

2. Use the following command to SSH into the VM:

   ```bash
   ssh <Your-Username>@<Public-IP-Address>
   ```

   Replace `<Your-Username>` with the admin username you specified during VM creation and `<Public-IP-Address>` with the IP address retrieved in the previous step.

### 4. Optional: Verify SSH Key Authentication

Once connected to the VM, you can verify SSH key authentication:

1. Check the `~/.ssh/authorized_keys` file on the VM.
   ```bash
   cat ~/.ssh/authorized_keys
   ```
2. Ensure it matches your public key.

---

## Key Components and Resources

### 1. **SSH Key Pair**

- **Public Key**: Shared with Azure to enable secure authentication.
- **Private Key**: Kept locally and used for establishing a connection.

### 2. **Azure Resource Group**

A logical container for Azure resources like VMs, storage accounts, and networking components.

### 3. **Virtual Machine**

A virtualized server running in the Azure cloud. Configured with an OS image (e.g., Ubuntu) and admin credentials.

### 4. **Azure CLI**

A command-line tool to create, configure, and manage Azure resources.

---

## Notes and Best Practices

- **Security**: Always protect your private SSH key with a strong passphrase.
- **Firewall Rules**: Ensure port 22 is open in the VM's network security group to allow SSH connections.
- **Backup**: Keep a backup of your SSH keys in a secure location.

---

## Troubleshooting

1. **Permission Denied (Public Key)**: Ensure your private key has the correct permissions:
   ```bash
   chmod 600 ~/.ssh/id_rsa
   ```
2. **Connection Timeout**: Verify that port 22 is open in the network security group and the VM is running.
3. **Missing Public Key**: Double-check the `~/.ssh/authorized_keys` file on the VM.
