# Container Auto Scaling
This project demonstrates how we can use **AWS ECS** to automatically scale containers.


## Notes
- The main focus of this repository is **Auto-Scaling application** using `AWS ECS`.
- The Flask (web framework written in Python) app was not given the proper attention. It's been developed so that an 
app can be run. It is neither well structured nor optimized.


## How It Functions
- Auto-Scaling comes into action based on the number of requests user send to the server. 
- Request first come to an Application Load Balancer (ALB).
- ALB forwards requests to the target, i.e., the **containers** (the servers).
- There are two **CloudWatch** metrics to monitor the **Request Count Per Server** and then take auto-scaling action 
based on the metric **threshold**.
- One metric monitor to perform **Scale-Out** action, another one do to perform **Scale In** action.
