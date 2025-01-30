# **Running a Node.js Application on Azure VM**

### **Steps to Deploy and Run the Application**

#### 1. **Download and Transfer App Files**

- **Download and Unzip** the app files on your local machine.
- Use the `scp` command to transfer files from your local machine to the Azure VM:
  ```bash
  scp -r /path/to/app adminuser@<vm-ip-address>:/home/adminuser/
  ```

#### 2. **Install Dependencies**

- SSH into your Azure VM:
  ```bash
  ssh adminuser@<vm-ip-address>
  ```
- Navigate to the app directory and install dependencies:
  ```bash
  cd /home/adminuser/<app-folder>
  npm install
  ```

#### 3. **Run the Application**

- Start the app:
  ```bash
  npm start
  ```
- Access the application by navigating to:
  ```
  http://<vm-ip-address>:3000
  ```

---

### **Deploying via Git**

You can also deploy the app using **Git**:

### Before these steps you must have initialised the folder on your local machine (git init) as well as synched it with a remote repository on github. That way you can push the code changes onto your remote repo

1. SSH into your Azure VM:
   ```bash
   ssh adminuser@<vm-ip-address>
   ```
2. Clone your repository:
   ```bash
   git clone <repository-url>
   ```
3. Navigate to the cloned directory and install dependencies:
   ```bash
   cd <repo-folder>
   npm install
   npm start
   ```
4. Access the app at:
   ```
   http://<vm-ip-address>:3000
   ```

---

### **Preparing a Generalized Image**

1. **Document Installation Commands**

   - Document all commands used to install dependencies in a file for future reference.

2. **Move App to Root Directory**

   - Move your app to the root directory under `/repo/app`:
     ```bash
     sudo mkdir -p /repo/app
     sudo mv /home/adminuser/<app-folder>/* /repo/app/
     ```

3. **Wipe User Data**

   - Use the `waagent` command to prepare the VM:
     ```bash
     sudo waagent -deprovision+user
     ```

4. **Create the Image**

   - In Azure, create an image with the name:  
     `tech501-yahya-sparta-app-ready-to-run-img`
   - If you receive a "Plan information" error, delete the VM and create a new one using the image:  
     `yahya-official-ubuntu2204-clean-image` in the `tech501` resource group.

5. **Test the Image**
   - Create a new VM from the image, log in, and test the app:
     ```bash
     cd /repo/app
     npm install
     npm start
     ```

---
