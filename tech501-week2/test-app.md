# Checklist/Plan for Creating an App & Database Images

> **Note:** You might have already completed some of the initial steps. If that's the case, identify where you're at and continue from that point.

## Step 1: Set Up Database VM

- **Create a new VM** for the database using a custom base image.
- **Manually provision the database** on the VM, ensuring it is set up and ready for use.

## Step 2: Validate Database Setup

- **Test the database setup** to confirm it's working properly.
- **What to verify?** Ensure the database is fully provisioned and accessible, and that no configuration errors exist.

## Step 3: Set Up App VM

- **Create a new VM** for the application using a custom base image.
- **Manually provision the app** on this VM.
  - Ensure the app runs without a database connection to confirm the app's functionality independently.
  - Ensure the app works **with the database connection** by setting up the connection to the database.
  - Set the `DB_HOST` environment variable for the app.
  - Double-check that the `DB_HOST` variable is pointing to the correct database IP address.

## Step 4: Test the Application

- Verify the public IP address to access the app's homepage.
- Test the `/posts` page to ensure it is functioning and connects to the database correctly.

## Step 5: Create a Database VM Image

- **Create an image** from the DB VM you've set up.
- **Delete the DB VM** to save resources, as you now have the image.

## Step 6: Recreate Database VM from the Image

- **Spin up a new DB VM** using the image you just created.

## Step 7: Create an App VM Image

- **Create an image** from the app VM that you set up.
- **Delete the app VM** to clean up your environment.

## Step 8: Recreate App VM from the Image

- **Create a new app VM** using the image you made in Step 7.
- Use a short **Bash script** in user data (don't worry about Bit—it will be covered later) to automate the setup. Alternatively, manually log into the app VM to test the app (including the `/posts` page).
  - **Script (`run-app-only.sh`)** should be stored in your documentation repository.
  - Include the following in the script:
    - A shebang at the top (e.g., `#!/bin/bash`).
    - Export the `DB_HOST` variable, pointing to the correct IP of your database.
    - Navigate into the app directory (`cd repo/app`).
    - Optionally, run `npm install` if needed to install dependencies (useful if you want to seed the database or check the DB connection).
    - Stop any running processes using `pm2 stop all`.
    - Start the app using `pm2 start app.js`.
  - Verify that the `/posts` page loads correctly and connects to the database VM.

```bash
#!/bin/bash

# Navigating into the app folder
cd repo/app

# Export DB_HOST with the correct IP address
export DB_HOST=mongodb://10.0.3.4:27017/posts

# Start the app
pm2 start app.js
```
