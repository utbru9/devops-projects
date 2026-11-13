# Incident Simulations

## High-Memory Simulation

### Alarm Configuration

```text
Metric: mem_used_percent
Threshold: Greater than 80%
Period: 5 minutes
Datapoints: 2 out of 2
Notification: devops-monitoring-alerts
```

### Generate Controlled Memory Pressure

```bash
sudo dnf install -y stress-ng

stress-ng \
  --vm 1 \
  --vm-bytes 60% \
  --vm-keep \
  --timeout 12m \
  --metrics-brief
```

Emergency stop:

```bash
sudo pkill stress-ng
```

### Expected Result

```text
Memory usage rises above 80%
→ CloudWatch Agent publishes mem_used_percent
→ Alarm changes from OK to ALARM
→ Amazon SNS sends an email
```

### Recovery

```text
stress-ng stops
→ Memory usage decreases
→ Healthy datapoints arrive
→ Alarm changes from ALARM to OK
```

## Test Status

```text
Not yet executed
```

The status and sanitized evidence will be updated after testing.
