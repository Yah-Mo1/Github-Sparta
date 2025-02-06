# Task Goal

The objective is to create a personal GitHub repository to facilitate cloning of the `app` folder.

## Requirements:

- Create a new GitHub repository with a suitable name (e.g., `my-app-repo`).
- Copy the `app` folder into the repository.
- Include a `README.md` file with a brief description of the repository’s purpose.
- Use an efficient method to copy the `app` folder.

## Steps to Achieve This

### 1. Create a GitHub Repository

First, we create a new GitHub repository and update the `README.md` file to provide a brief explanation of the repository’s purpose.

![GitHub Repo Screenshot](<Screenshot 2025-02-06 at 11.53.04.png>)

### 2. Clone the Repository Locally

Next, we use the `git clone` command to download the repository onto our local machine:

git clone <remote-repo-endpoint> 3. Copy the app Folder into the Repository
Since we already have the app folder in our Downloads directory, we can efficiently copy it into the newly cloned repository using the following command:

cp -r ~/Downloads/app ./my-app-repo/

Now, the app folder is successfully placed inside the repository.

4. Push Changes to GitHub
   Finally, we use the Git workflow to commit and push the changes back to the remote repository:

git add .
git commit -m "Added app folder to GitHub repository"
git push
Once this is done, we can confirm that the app folder is now present in our remote GitHub repository.

```

```
