# CI/CD Jenkins Workflow

When we push code changes from the development (`dev`) branch, the CI/CD Jenkins pipeline is automatically triggered. This happens because a webhook is created to link the version control system (VCS) with the Jenkins pipeline.

Jenkins operates using nodes, which include agent and worker nodes. Agent nodes manage worker nodes and assign jobs to them. Once the master node delegates tasks to the worker nodes, the following three jobs will execute successfully within the worker node:

1. **Pull Code Changes from VCS**

   - The worker node fetches the latest updates from the `dev` branch.

2. **Merge `dev` Branch into `main`**

   - The changes from the `dev` branch are merged into the `main` branch.

3. **Deploy the Code**
   - The final step is to deploy the updated code.

![alt text](<Screenshot 2025-02-06 at 11.26.48.png>)

Next, we will create a private key
cd into .ssh-github

generate key pair
ssh-keygen -t rsa -b 4096 -C "your-email@example.com

store public key in github deploy keys
![alt text](<Screenshot 2025-02-06 at 13.55.54.png>)

Next, we use jenkins to create and configure a jenkins pipeline

![alt text](<Screenshot 2025-02-06 at 14.38.23.png>)

![alt text](<Screenshot 2025-02-06 at 14.38.10.png>)

![alt text](<Screenshot 2025-02-06 at 14.38.01.png>)

We added this bash script to execute each time the job runs

![alt text](<Screenshot 2025-02-06 at 15.13.29.png>)

Once that is done, you should run the job and see successful output
![alt text](<Screenshot 2025-02-06 at 14.49.50.png>)

Adding webhooks:

Now lets modify our jenkins pipeline to execute each time a push event happens, for this we need to create a webhook
On build triggers, check the GitHub hook trigger for GITScm polling

![alt text](<Screenshot 2025-02-06 at 15.14.18.png>)

Next, create a webhook on github repo

![alt text](<Screenshot 2025-02-06 at 15.15.35.png>)

then, make a small change on your readme file and push to git repo, you should see that the pipeline automatically executes when you push the code changes
