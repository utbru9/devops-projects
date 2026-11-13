# Unified CloudWatch Dashboard

## Dashboard Name

```text
devops-unified-observability
```

## Purpose

This dashboard provides one operational view for EC2 infrastructure, Amazon Linux operating-system metrics, NGINX application logs, Lambda telemetry, and CloudWatch alarm states.

## Row 1: Alarm Overview

Add an alarm-status widget containing:

- `cloudwatch-lab-high-memory`
- `cloudwatch-lab-high-disk`
- `cloudwatch-lab-high-cpu`
- `cloudwatch-lab-status-check-failed`
- `cloudwatch-lab-nginx-404-spike`
- `ec2-scheduler-lambda-errors`

## Row 2: EC2 Infrastructure

Add metric widgets for:

- `CPUUtilization`
- `mem_used_percent`
- `disk_used_percent`
- `NetworkIn`
- `NetworkOut`
- `StatusCheckFailed`

## Row 3: Lambda Workload

Add metric widgets for:

- Invocations
- Errors
- Duration
- Throttles

Lambda function:

```text
ec2-tag-scheduler
```

## Row 4: Application Observability

Add widgets for:

- NGINX 404 count
- NGINX access-log query
- NGINX error-log query
- Lambda error query

## Data Sources

### Custom Metrics Namespace

```text
DevOpsPortfolio/EC2
```

### CloudWatch Log Groups

```text
/devops/cloudwatch-lab/system
/devops/cloudwatch-lab/nginx/access
/devops/cloudwatch-lab/nginx/error
/aws/lambda/ec2-tag-scheduler
```

## Expected Outcome

The dashboard combines metrics, logs, and alarm states in one place. This reduces the need to switch between the EC2, Lambda, CloudWatch Logs, and CloudWatch Alarms pages during troubleshooting.
