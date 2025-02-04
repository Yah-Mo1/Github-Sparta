# Securing the Database with a 3-Subnet Architecture

## Virtual Network Setup

To enhance security, we configure a **Virtual Network (VNet)** with three distinct subnets:

### 1. Public Subnet

- **CIDR:** `10.0.2.0/24`
- This subnet is publicly accessible.

### 2. DMZ Subnet

- **CIDR:** `10.0.3.0/24`
- Acts as a buffer zone between public and private networks.  
  ![DMZ Subnet](<Screenshot 2025-01-31 at 13.18.51-1.png>)

### 3. Private Subnet

- **CIDR:** `10.0.4.0/24`
- Used for securing sensitive resources, such as databases.  
  ![Private Subnet](<Screenshot 2025-01-31 at 13.19.11-1.png>)

### Private Access Configuration

When setting up the **private subnet**, ensure that **private outbound access** is enabled for secure communication.  
![Private Access](<Screenshot 2025-01-31 at 13.19.44-1.png>)

Next, well work on creating our VMs, Lets start by creating the app vm

Basic Configuration
Go onto images, and use your app image in order to create your app vm
Keep the naming convention the same as you have done in previous examples,
use zone 1 availabiltity zone, as well as your private key stored in azure, and set license type to other
![alt text](<Screenshot 2025-02-03 at 11.18.41.png>)

Disks:
under disk, keep it standard ssd and enable delete with vm

Networking Configuration
choose your public subnet created
configure the NSG to allow inboudn rules at port 80 http and port 22 ssh
![alt text](<Screenshot 2025-02-03 at 11.22.13.png>)

Next Go on advanced, click user data, and copy the bash script to set up and run our application and paste it onto the user data text box,

#!/bin/bash

# Navigating into the app folder

cd repo/app

# Export DB_HOST with the correct IP address

export DB_HOST=mongodb://PrivateIp:27017/posts

# Start the app

pm2 start app.js

```

Ensure that the Database Private IP is correct

Go on Tags and assign your tag (owner tag, value)

Finally, click on review + Create your VM, and Create your DB VM

![alt text](<Screenshot 2025-02-03 at 11.40.02.png>)


Next we will create our db vm:
Go onto images, and use your app image in order to create your app vm
Keep the naming convention the same as you have done in previous examples,
use zone 3 availabiltity zone, as well as your private key stored in azure, and set license type to other
![alt text](<Screenshot 2025-02-03 at 11.27.39.png>)

Disks:
under disk, keep it standard ssd and enable delete with vm

Networking Configuration
choose your Private subnet created
Click no Public Ip
and check delete NIC when VM is deleted

![alt text](<Screenshot 2025-02-03 at 11.30.39.png>)

Go on Tags and assign your tag (owner tag, value)

Finally, click on review + Create your VM, and Create your DB VM

![alt text](<Screenshot 2025-02-03 at 11.32.31.png>)
```

Now that we have successfuuly created the App and DB Vm, we will monitor the connection between both vms.
To do this:
lets conncet to our app virtual machine using ssh

ssh -i privatekey azureuser@PublicIp

Once we are connected to our app vm, we send a ping message to ensure that our db vm exists and is connected

ping privateIp (of database VM)

![alt text](<Screenshot 2025-02-03 at 12.06.10.png>)

As you can see, we are getting responses back to the Database every second. Confirming the connection established between both vms

Now we will create our DMZ VM:
Basic configuration similar to previous VMs we have created, except this time we are not using an image, and we set our availability zone to zone 2

![alt text](<Screenshot 2025-02-03 at 12.11.36.png>)

Disks:
under disk, keep it standard ssd and enable delete with vm

Networking Configuration:
Select DMZ Subnet created, and select public Ip

Go on Tags and assign your tag (owner tag, value)

Finally, click on review + Create your VM, and Create your DMZ VM

![alt text](<Screenshot 2025-02-03 at 12.18.47.png>)

Next we will create a route table to connect to our private subnet

![alt text](<Screenshot 2025-02-03 at 12.22.26.png>)

Next, we will create a route within this route table
![alt text](<Screenshot 2025-02-03 at 12.29.43.png>)

now you should see that the ping responses have now stopped

Next go to your nva/dmz vm and go onto network settings, enable ip forwarding
then using ssh connect to this vm

Then run this command --> sysctl net.ipv4.ip_forward
explain what the command does!
as you can see, it is 0

Next run this command to edit the file --> sudo vim /etc/sysctl.conf
and uncomment the line to enable ipv4 forwading

run the command to check for ip forwarding above, you can now see it has changed to 1

Once that is done, you should see that the ping is now working (connection established between both db and app vm once again)

Configure IP Tables on the NVA VM
Creating a bash script that will load up all our IP table rules (Time Efficient):

Disclaimer: The wrong IP table/firewall rules or rules setup in the wrong order, can possibly lock yourself out your VM.

SSH into the NVA VM and run:

nano config-ip-tables.sh
Refer to config-script and give executable permissions with chmod +x config-ip-tables.sh.

As the APP VM sends packets/traffic (ping) to the NVA, everything is getting forwarded on to the DB VM. The IP tables rules filters traffic according to the rules.

Best practice: Double-check load page works before testing script and run:

./config-ip-tables.sh

Step 9: Apply Stricter Security Rules for the Database VM
Setting up stricter rules so only mongo DB and SSH will be accepted. Everything else will be denied. No other traffic will be let through on the NSG on the DB VM.

Restrict SSH Access
Go to Azure portal > Database VM > Network Settings > NSG > Inbound rules

Edit SSH rule

Source: Select SSH only from trusted IP addresses

Source IP/CIDR: 10.0.2.0/24

Service: MongoDB

Action: Allow

![alt text](<Screenshot 2025-02-03 at 13.55.56.png>)

Update the Network Security Group (NSG) rules in Azure to enforce this.

Deny Everything Else Rule

Add New rule

Any other traffic from any other source, going to any other port will be denied.

Change destination port to an \*

Action: Deny

Priority: Make it a higher priority like 1000.

![alt text](<Screenshot 2025-02-03 at 13.56.28.png>)

Conclusion
By following this guide, you have successfully set up a secure 3-subnet architecture in Azure. The database VM is now isolated, and all traffic is routed through the NVA for added security. Make sure to regularly review and update your security rules to maintain a robust defense against potential threats.
