# Incident Health Snapshot

## Project Overview

This project automates the collection of Linux system health information during production incidents.

The script generates a single report containing important system metrics to help on-call engineers investigate server performance issues before making changes.

## Objectives

- Monitor system uptime and load average.
- Analyze memory utilization.
- Capture running processes.
- Monitor filesystem disk usage.
- Identify the largest directories under /var.
- Identify listening network ports.
- Generate a consolidated health report.

## Technologies Used

- Linux
- Bash Scripting
- System Monitoring
- Process Management
- Disk Management
- Network Diagnostics

## Commands Used

| Command | Purpose |
|---|---|
| uptime | System uptime and load |
| free -h | Memory utilization |
| ps aux | Running processes |
| df -h | Filesystem disk usage |
| du -h | Directory size |
| sort -h | Sort directory sizes |
| ss -tulnp | Listening network ports |

## Project Structure

```text
02-incident-health-snapshot/
├── README.md
├── capture-health.sh
└── setup-sample-logs.sh
