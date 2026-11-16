# AWS EC2 Auto Scaling E-Commerce Platform

CloudCart is a simulated e-commerce website deployed on highly
available AWS infrastructure.

The project represents an e-commerce platform experiencing increased
customer demand during a peak sales season. An AWS Application Load
Balancer distributes requests across healthy NGINX web servers, while
an EC2 Auto Scaling group automatically adjusts server capacity
according to average CPU utilization.

## Business Scenario

CloudCart is running a promotional peak-sales event.

During the event:

1. Customer demand increases.
2. Requests enter through an Application Load Balancer.
3. The load balancer distributes traffic across healthy EC2 servers.
4. CloudWatch monitors average CPU utilization.
5. EC2 Auto Scaling launches additional servers when utilization rises.
6. New servers register with the target group.
7. The load balancer starts routing requests to the new healthy servers.
8. EC2 Auto Scaling removes excess servers after demand decreases.
9. Amazon SNS sends instance lifecycle notifications.

This is a controlled infrastructure simulation. No real payments,
orders or customer information are processed.

## Architecture

```text
Customers
    |
Internet Gateway
    |
Application Load Balancer
    |
Target Group
    |
EC2 Auto Scaling Group
    |
NGINX E-Commerce Web Servers
```

## AWS Services

- Amazon VPC
- Internet Gateway
- Public route table
- Amazon EC2
- Amazon Machine Image
- EC2 Launch Template
- Application Load Balancer
- Target Group
- EC2 Auto Scaling
- Amazon CloudWatch
- Amazon SNS

## Capacity Configuration

| Setting | Planned value |
|---|---:|
| Minimum capacity | 2 |
| Desired capacity | 2 |
| Maximum capacity | 4 |
| Scaling metric | Average CPU utilization |
| Target utilization | 50% |
| Health-check path | `/health.html` |
| Initial Availability Zones | 2 |

## Website Features

The CloudCart storefront includes:

- Peak-sales promotional banner
- Discounted product catalog
- Featured-product section
- Demo cart counter
- Responsive layout
- AWS architecture explanation
- EC2 hostname display
- Application health endpoint

## Repository Structure

```text
aws-ec2-auto-scaling-web-platform/
├── architecture/
├── docs/
├── screenshots/
├── scripts/
│   ├── cpu-load-test.sh
│   ├── install-web-server.sh
│   └── stop-cpu-load-test.sh
├── website/
│   ├── health.html
│   └── index.html
└── README.md
```

## Planned Tests

The completed project will validate:

1. CloudCart availability through the load balancer.
2. Request distribution across multiple healthy EC2 instances.
3. Healthy targets in two Availability Zones.
4. Automatic replacement of a terminated instance.
5. Replacement of an instance with a failed NGINX service.
6. CPU-based scale-out during simulated peak demand.
7. Automatic scale-in after demand decreases.
8. Minimum and maximum capacity enforcement.
9. Amazon SNS launch and termination notifications.

## Security Principles

- No AWS credentials are stored in GitHub.
- No EC2 private keys are stored in GitHub.
- SSH access is restricted.
- EC2 web traffic is accepted only from the load balancer.
- Sensitive identifiers are removed from screenshots.
- The storefront does not collect customer or payment information.

## Project Status

Application preparation is complete.

AWS infrastructure implementation is the next phase.
