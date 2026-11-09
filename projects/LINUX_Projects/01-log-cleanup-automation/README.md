# Project 01 - Automated Log Cleanup

## Overview
Automates the removal of old rotated application log files using Bash scripting and Cron.

## Problem Statement
Application servers continuously generate log files. Over time, old log files consume disk space and require manual cleanup.

This project solves the problem by scheduling an automated cleanup process.

## Technologies
- Linux
- Bash
- Cron
- Find
- File Permissions

## Features
- Automatically deletes files ending in `.old`.
- Preserves the active `app.log`.
- Runs automatically every 5 minutes.
- Maintains execution history in `cleanup.log`.

## Implementation

### Script Location
`src/cleanup.sh`

### Cron Configuration
`configs/crontab.cron`

### Execution Permission
```bash
chmod +x /root/bin/cleanup.sh
```

### Manual Execution
```bash
/root/bin/cleanup.sh
```

### Verification
```bash
ls -l /var/log/escbash-app/
cat /var/log/escbash-app/cleanup.log
crontab -l
```

## Expected Result
- Old `.old` files are deleted.
- Active application logs remain untouched.
- Cleanup runs every five minutes.
- Execution records are maintained.

## Learning Outcomes
- Linux file management
- Bash scripting
- Cron scheduling
- File permissions
- Log management and automation

## Status
Completed
