# Troubleshooting Journal

## Incorrect Operating-System Assumption

The initial CloudWatch Agent configuration targeted Ubuntu and Apache:

```text
/var/log/syslog
/var/log/apache2/access.log
/var/log/apache2/error.log
```

The monitored EC2 instance was Amazon Linux 2023 running NGINX.

The configuration was corrected to:

```text
/var/log/messages
/var/log/nginx/access.log
/var/log/nginx/error.log
```

## Apache and NGINX Port Conflict

Apache `httpd` and NGINX both attempted to listen on TCP port 80.

The port owner was identified with:

```bash
sudo ss -ltnp | grep ':80 '
```

NGINX failed with:

```text
bind() to 0.0.0.0:80 failed
Address already in use
```

Apache was disabled and NGINX was enabled:

```bash
sudo systemctl disable --now httpd
sudo systemctl enable --now nginx
```

## Invalid CloudWatch Agent Configuration

The generated agent configuration was accidentally edited directly, producing invalid JSON.

The configuration was recovered by:

1. Stopping the CloudWatch Agent.
2. Removing the corrupted generated file.
3. Creating a clean source configuration.
4. Validating the JSON with `python3 -m json.tool`.
5. Applying the source configuration with `fetch-config`.

## Missing NGINX Access Log Group

The NGINX access log was initially empty, so the CloudWatch Agent had no events to publish.

Test traffic was generated:

```bash
for i in {1..10}; do
  curl -s "http://127.0.0.1/cloudwatch-real-test-$i" > /dev/null
done
```

The access events then appeared in:

```text
/devops/cloudwatch-lab/nginx/access
```

## Validated Results

Custom metrics:

```text
mem_used_percent
disk_used_percent
swap_used_percent
```

Centralized log groups:

```text
/devops/cloudwatch-lab/system
/devops/cloudwatch-lab/nginx/access
/devops/cloudwatch-lab/nginx/error
```
