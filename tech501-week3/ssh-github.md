# Authenticating into GitHub using SSH from Our Local Machine

This guide explains how to authenticate into GitHub using SSH from a local machine.

## Generating an SSH Key Pair

First, generate an SSH key pair using the following command:

```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

````

- Name your private key: `yourname-github-key`
- Press enter for the following prompts.

<img src="Screenshot%202025-02-04%20at%2014.58.11.png" width="500">

## Adding the SSH Key to GitHub

1. Log into GitHub.
2. Navigate to **Settings** and click **SSH and GPG Keys**.

<img src="Screenshot%202025-02-04%20at%2014.58.51.png" width="500">

3. Click **New SSH key** and register your public key.

## Configuring SSH Agent

Next, run the following command to start the SSH agent:

```sh
eval `ssh-agent -s`
```

### Explanation

This command starts the SSH agent, a background process that manages SSH keys and authentication.

Now, add the private key to the SSH agent:

```sh
ssh-add <key name>
```

## Testing the SSH Connection

Verify that the authentication is working by running:

```sh
ssh -T git@github.com
```

<img src="Screenshot%202025-02-04%20at%2015.14.25.png" width="500">

If successful, GitHub will return a confirmation message.

## Creating a Test Repository

Create a test repository on GitHub named `test-ssh`.

<img src="Screenshot%202025-02-04%20at%2015.23.48.png" width="500">

## Initializing and Pushing Changes from Local Machine

Once the repository is created, initialize an empty folder on your local machine and push changes.

### 1. Create a Directory

```sh
mkdir test-ssh
cd test-ssh
```

### 2. Create a Test File

```sh
echo "this is a test file" > test.md
```

### 3. Follow the Git Workflow

```sh
git init
git add .
git commit -m "push test file"
git remote add origin <repository_url>
git push --set-upstream origin main
```

And voilà! 🎉 Your changes are now pushed to the new GitHub repository.

<img src="Screenshot%202025-02-04%20at%2015.25.32.png" width="500">

```

Save this as `README.md`, and it will properly format in GitHub or any Markdown viewer. Let me know if you need any modifications! 🚀
```
````
