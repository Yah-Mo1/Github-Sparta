# Advantages of CI/CD (Continuous Integration & Continuous Deployment)

✅ **Increased Automation, Less Manual Effort**  
CI/CD streamlines development by automating builds, testing, and deployments. This reduces repetitive tasks, allowing developers and IT teams to focus on innovation.

⚡ **Faster Releases, Greater Business Impact**  
With CI/CD, new features, bug fixes, and updates can be deployed quickly. Users receive the latest improvements faster, enhancing overall business value.

🔒 **Lower Risk, Higher Stability**  
Frequent and incremental changes reduce the likelihood of major issues. Automated workflows ensure consistency, minimize human errors, and keep deployments reliable.

CI/CD isn't just a process—it's a smarter way to develop, test, and deploy software! 🚀

---

## **Continuous Integration (CI)**

### **Branching Strategy:**

`Feature Branch → Dev Branch → Main Branch`

- Developers push updates to a feature branch, triggering an automated build and test process through CI.
- If all tests pass, changes are merged into the `dev` or `main` branch.
- CI runs frequently on feature branch updates to maintain code quality.
- A webhook (e.g., connected to Jenkins) notifies the CI server of new changes, initiating the required jobs.
- In our case, we are validating new application code instead of building containerized images or custom Azure VM images. If successful, the changes are merged into `main`.

---

## **Continuous Deployment (CD)**

- Once CI is complete, CD takes over by deploying the tested code to production automatically.
- In this setup, deployment occurs on a virtual machine (VM), but in other environments, the CI output may be a Docker container deployed to Kubernetes clusters.
- When multiple developers work on different feature branches, keeping the codebase synchronized is essential.
- After rigorous testing, only stable and verified updates are pushed to production.
- Once deployed, new features and improvements become instantly available to users.

# Setting Up Jenkins

1. Launch Jenkins and open the web interface (`http://52.31.15.176:8080/` by default).
2. Use your administrator password to unlock Jenkins.
3. Install the recommended plugins for optimal functionality.
4. Create an admin user and complete the initial setup process.

---

## **Creating a Freestyle Project**

1. Navigate to the **Jenkins Dashboard**.
2. Click **New Item**.
3. Provide a project name and choose **Freestyle Project**.
4. Click **OK** to proceed.
5. On the configuration page, locate the **Build Steps** section.
6. Click **Add build step > Execute shell**.
7. Input the required shell commands to define your build process.
8. Click **Save** to finalize the setup.

---

## **Running and Executing Jobs**

1. From the **Jenkins Dashboard**, select the freestyle project you created.
2. In the **Build Steps** section, choose **Execute shell** and enter the necessary commands.
3. Monitor job execution in the **Build History** panel.
4. Click on a specific build number to access detailed logs.
5. Convert your project into a multi-stage build by selecting:  
   **Post-Build Actions > Build Other Project**.
6. The console output should display:  
   `Started from...`

📌 _ENTER-SCREENSHOT-HERE_

---

## **Creating a Multi-Stage Pipeline**

1. Go to the **Jenkins Dashboard**.
2. Click **New Item**.
3. Provide a name and choose **Pipeline**.
4. Click **OK** to proceed.
5. Scroll to the **Pipeline** section.
6. Select **Pipeline Script** and enter your multi-stage pipeline configuration.
   - Example: A script that outputs the current time.
