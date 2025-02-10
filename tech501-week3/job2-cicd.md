# Jenkins Job: Merging Dev Branch into Main

## Overview

This document outlines the steps to configure a Jenkins job that merges changes from the `dev` branch into the `main` branch whenever changes are pushed to `dev`.

## Prerequisites

- Jenkins is installed and running.
- Git is installed on the Jenkins server.
- The repository has a `dev` and `main` branch.
- SSH credentials are configured in Jenkins.
- Webhooks (GitHub/GitLab) are set up to trigger the job on push events to `dev`.

## Step 1: Create a New Jenkins Job

1. Navigate to **Jenkins Dashboard**.
2. Click on **New Item**.
3. Enter a job name following the naming convention of **Job1**, specifying that this job is for dev merge (e.g., `Dev-Merge-Job`).
4. Select **Freestyle Project** and click **OK**.

![alt text](<Screenshot 2025-02-06 at 15.29.37.png>)

![alt text](<Screenshot 2025-02-06 at 15.28.58.png>)

## Step 2: Configure Source Code Management (SCM)

1. Scroll down to **Source Code Management**.
2. Select **Git**.
3. Enter the repository URL.
4. Under **Branches to build**, enter `dev`.
5. Ensure the appropriate credentials (SSH or HTTPS) are selected.

## Step 3: Configure Build Triggers

1. Check **Poll SCM** (if using polling) or set up a webhook to trigger the job on push events to `dev`.
2. If using polling, enter an appropriate schedule (e.g., `H/5 * * * *` for every 5 minutes).
3. Ensure that Build after other projects are built and add job1 as a project to watch

## Step 4: Add SSH Agent (if using SSH Authentication)

1. Scroll down to **Build Environment**.
2. Check the **SSH Agent** checkbox.
3. Select the appropriate SSH credentials.

![alt text](<Screenshot 2025-02-06 at 17.32.20.png>)

## Step 5: Add Shell Script for Merging

1. Scroll to **Build** → **Add build step** → **Execute shell**.
2. Copy and paste the following script:

```sh
# Checkout main branch
git checkout main

# Pull latest changes from main
git pull origin main

# Merge dev branch using fast-forward merge
git merge --ff-only origin/dev

# Push merged changes back to main
git push origin main
```
