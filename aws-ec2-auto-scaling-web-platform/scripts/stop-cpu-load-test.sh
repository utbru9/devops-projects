#!/bin/bash

set -euo pipefail

echo "Stopping CloudCart peak-sales CPU simulation..."

pkill -x yes || true

echo "CPU simulation stopped."
