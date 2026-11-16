#!/bin/bash

set -euo pipefail

WORKERS="${1:-2}"
DURATION="${2:-600}"

if ! [[ "${WORKERS}" =~ ^[1-9][0-9]*$ ]]; then
  echo "WORKERS must be a positive integer."
  exit 1
fi

if ! [[ "${DURATION}" =~ ^[1-9][0-9]*$ ]]; then
  echo "DURATION must be a positive integer."
  exit 1
fi

echo "CloudCart peak-sales load simulation"
echo "CPU workers: ${WORKERS}"
echo "Duration: ${DURATION} seconds"

for ((worker = 1; worker <= WORKERS; worker++)); do
  timeout "${DURATION}" yes > /dev/null &
done

echo "CPU load simulation started."
echo "Use stop-cpu-load-test.sh to stop it early."
