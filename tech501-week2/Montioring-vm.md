### How to Monitor Your System

1. **Navigate to the Monitor Tab**

   - Open the monitoring section of your VM.

2. **Create a Dashboard**

   - Set up a new dashboard to visualize system metrics.
     ![alt text](<Screenshot 2025-02-04 at 16.49.17.png>)

3. **Add Relevant Metrics**

   - Include key performance indicators such as:
     - CPU Usage
     - Networking Activity
     - Disk Operations (Read/Write speeds, IOPS)

![alt text](<Screenshot 2025-02-04 at 16.53.10.png>)

4. **Set a Time Frame**

- Define a suitable time range for analysis (e.g., last hour, last 24 hours, custom range).

---

### Using Apache for Load Testing

To test your application's performance under load, use the Apache Benchmark tool (`ab`).

#### **Installation**

```sh
sudo apt-get install apache2-utils
```

#### **Run a Load Test**

```sh
ab -n 1000 -c 100 http://yourwebsite.com/
```

- `-n 1000`: Sends 1000 total requests
- `-c 100`: Sends 100 concurrent requests

![alt text](<Screenshot 2025-02-04 at 16.56.53.png>)

Next, you should see your CPU metric spike up because of this
![alt text](<Screenshot 2025-02-04 at 16.56.36.png>)

Next, we will set up an alert such that when the cpu reaches a certain level, we will get an email notification of this:

Lets create the action group:

![alt text](<Screenshot 2025-02-06 at 09.13.21.png>)

Lets verify that we have configured the alert rule correctly.

![alt text](<Screenshot 2025-02-06 at 09.14.15.png>)

The result:

![alt text](<Screenshot 2025-02-06 at 10.01.03.png>)

This helps simulate real-world traffic and measure your system’s response time under stress. 🚀
