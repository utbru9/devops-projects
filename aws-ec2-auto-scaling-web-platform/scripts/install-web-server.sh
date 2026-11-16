#!/bin/bash

set -euo pipefail

PROJECT_NAME="CloudCart Peak Sales Auto Scaling Platform"
WEB_ROOT="/usr/share/nginx/html"

GITHUB_RAW_BASE="https://raw.githubusercontent.com/utbru9/devops-projects/main/aws-ec2-auto-scaling-web-platform/website"

echo "============================================"
echo "Starting CloudCart web-server installation"
echo "============================================"

echo "Updating Amazon Linux packages..."
dnf update -y

echo "Installing NGINX..."
dnf install -y nginx

echo "Creating the NGINX document root..."
mkdir -p "${WEB_ROOT}"

echo "Downloading the CloudCart storefront..."
curl \
  --fail \
  --silent \
  --show-error \
  --location \
  "${GITHUB_RAW_BASE}/index.html" \
  --output "${WEB_ROOT}/index.html"

echo "Downloading the health-check endpoint..."
curl \
  --fail \
  --silent \
  --show-error \
  --location \
  "${GITHUB_RAW_BASE}/health.html" \
  --output "${WEB_ROOT}/health.html"

echo "Adding the current EC2 hostname..."
INSTANCE_HOSTNAME="$(hostname)"

sed -i \
  "s/SERVER_HOSTNAME/${INSTANCE_HOSTNAME}/g" \
  "${WEB_ROOT}/index.html"

echo "Enabling and starting NGINX..."
systemctl enable --now nginx

echo "Validating the NGINX configuration..."
nginx -t

echo "Validating the storefront..."
curl \
  --fail \
  --silent \
  --show-error \
  http://localhost/ \
  > /dev/null

echo "Validating the load-balancer health endpoint..."
HEALTH_RESPONSE="$(
  curl \
    --fail \
    --silent \
    --show-error \
    http://localhost/health.html
)"

if [[ "${HEALTH_RESPONSE}" != "healthy" ]]; then
  echo "Health-check validation failed."
  echo "Received response: ${HEALTH_RESPONSE}"
  exit 1
fi

echo
echo "============================================"
echo "${PROJECT_NAME} installation completed"
echo "Server hostname: ${INSTANCE_HOSTNAME}"
echo "Health response: ${HEALTH_RESPONSE}"
echo "============================================"
