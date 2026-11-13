# CloudWatch Alarm Definitions

## Implemented Alarm

### High Memory

| Setting | Value |
|---|---|
| Alarm name | `cloudwatch-lab-high-memory` |
| Namespace | `DevOpsPortfolio/EC2` |
| Metric | `mem_used_percent` |
| Statistic | Average |
| Period | 5 minutes |
| Threshold | Greater than 80% |
| Evaluation | 2 out of 2 datapoints |
| Missing data | Treat as missing |
| Notification | `devops-monitoring-alerts` |

The alarm enters the `ALARM` state when average memory usage remains above 80% for two consecutive five-minute periods.

## Planned Alarms

| Alarm name | Metric | Condition |
|---|---|---|
| `cloudwatch-lab-high-disk` | `disk_used_percent` | Greater than 80% |
| `cloudwatch-lab-high-cpu` | `CPUUtilization` | Greater than 80% |
| `cloudwatch-lab-status-check-failed` | `StatusCheckFailed` | Greater than or equal to 1 |
| `cloudwatch-lab-nginx-404-spike` | `Nginx404Count` | At least 5 in 5 minutes |
| `ec2-scheduler-lambda-errors` | `Errors` | Greater than or equal to 1 |

## Notification Path

CloudWatch Alarm
→ SNS topic: devops-monitoring-alerts
→ Confirmed email subscription
