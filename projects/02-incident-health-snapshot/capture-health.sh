#!/bin/bash

# Incident Health Snapshot
# Collects system health information into a single report.

set -euo pipefail

REPORT_FILE="${1:-/root/health-report.txt}"

# Initialize report
sudo mkdir -p "$(dirname "$REPORT_FILE")"
sudo touch "$REPORT_FILE"
sudo chmod 644 "$REPORT_FILE"
sudo truncate -s 0 "$REPORT_FILE"

# 1. Uptime and load average
{
    echo "========================================"
    echo "1. UPTIME AND LOAD AVERAGE"
    echo "========================================"
    uptime
    echo
} | sudo tee -a "$REPORT_FILE" > /dev/null

# 2. Memory summary
{
    echo "========================================"
    echo "2. MEMORY SUMMARY"
    echo "========================================"
    free -h
    echo
} | sudo tee -a "$REPORT_FILE" > /dev/null

# 3. Running processes
{
    echo "========================================"
    echo "3. RUNNING PROCESSES"
    echo "========================================"
    ps aux
    echo
} | sudo tee -a "$REPORT_FILE" > /dev/null

# 4. Disk usage
{
    echo "========================================"
    echo "4. DISK USAGE"
    echo "========================================"
    df -h
    echo
} | sudo tee -a "$REPORT_FILE" > /dev/null

# 5. Largest folders under /var
{
    echo "========================================"
    echo "5. LARGEST FOLDERS UNDER /var"
    echo "========================================"
    sudo du -h --max-depth=1 /var 2>/dev/null | sort -h
    echo
} | sudo tee -a "$REPORT_FILE" > /dev/null

# 6. Listening ports
{
    echo "========================================"
    echo "6. LISTENING PORTS"
    echo "========================================"
    ss -tulnp
    echo
} | sudo tee -a "$REPORT_FILE" > /dev/null

echo "Health snapshot generated: $REPORT_FILE"
