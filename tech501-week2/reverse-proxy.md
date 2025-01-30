````markdown
## Setting Up a Reverse Proxy for Your Virtual Machine

To ensure your application runs on the Nginx port (or when accessing `http://ipaddress`), follow these steps:

1. Open the Nginx configuration file:

   ```bash
   sudo nano /etc/nginx/sites-available/default
   ```
````

2. Replace the contents of the `server` block with:

   ```nginx
   server {
       listen 80;
       server_name _;

       location / {
           proxy_pass http://localhost:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

3. Test the Nginx configuration:

   ```bash
   sudo nginx -t
   ```

4. Restart and enable Nginx:

   ```bash
   sudo systemctl restart nginx
   sudo systemctl enable nginx
   ```

---

## Make sure a connection is established with DB

1. When running Npm install, you should see that the database is connected --> Run sudo -E npm install so that npm has access to the environment variable (DB_HOST) when installing dependencies

## Running the Application in the Background

1. Install `pm2` globally:

   ```bash
   sudo npm install pm2 -g
   ```

2. Start your application using `pm2`:

   ```bash
   pm2 start app.js
   ```

3. Stop application using `pm2`
   ```bash
   pm2 stop app.js
   ```

```

![alt text](<Screenshot 2025-01-28 at 16.30.46.png>)
```
