## Testing the Pipeline Jobs

After creating all our jobs, the next step is to test them.

Let's begin by making a small modification to our code—adding an `<h2>` tag to the `index.ejs` page.

Next, we follow the Git workflow:

```bash
git add .
git commit -m "message"
git push
Once the code is pushed to the dev branch, the pipeline jobs should trigger automatically.
```

![alt text](<Screenshot 2025-02-10 at 16.20.48.png>)

As shown in the image, Job 3 is currently in the queue, as the previous jobs have already executed.

![alt text](<Screenshot 2025-02-10 at 16.21.02.png>)

Finally, you should see the updated content reflected on your front page.

![alt text](<Screenshot 2025-02-10 at 16.21.27.png>)
