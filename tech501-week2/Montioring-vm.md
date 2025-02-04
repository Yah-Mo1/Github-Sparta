### How to Monitor Your System

1. **Navigate to the Monitor Tab**

   - Open the monitoring section of your VM.

2. **Create a Dashboard**

   - Set up a new dashboard to visualize system metrics.

3. **Add Relevant Metrics**

   - Include key performance indicators such as:
     - CPU Usage
     - Networking Activity
     - Disk Operations (Read/Write speeds, IOPS)

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

This helps simulate real-world traffic and measure your system’s response time under stress. 🚀
