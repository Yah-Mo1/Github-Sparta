# Why Use Autoscaling?

## Problem: No Monitoring

- A single application VM without monitoring can become overwhelmed when CPU usage spikes.
- This leads to system failure, frustrated users, and financial losses.

## Solution 1: VM with Monitoring

- Monitoring tracks CPU usage, but if thresholds are missed on the dashboard, the issue might go unnoticed.
- The system still risks failure without timely intervention.

## Solution 2: Monitoring + Alerts

- When CPU load exceeds the limit, alerts (via email or messaging) notify administrators.
- However, scaling still requires manual action.

## Solution 3: Autoscaling with VM Scale Sets

- The system automatically scales based on CPU load—adding or removing VMs as needed.
- Ensures stability, performance, and cost efficiency.

## Scaling Approaches

- **Vertical Scaling**: Increases CPU, memory, or storage of a single VM (scaling up/down).
- **Horizontal Scaling**: Adjusts the number of VM instances (scaling in/out).

![alt text](<Screenshot 2025-01-31 at 10.08.17.png>)
