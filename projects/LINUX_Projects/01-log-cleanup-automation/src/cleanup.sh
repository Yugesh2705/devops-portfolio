#!/bin/bash

# Application log directory
LOG_DIR="/var/log/escbash-app"

# Remove old rotated log files
find "$LOG_DIR" -type f -name "*.old" -delete

# Print execution timestamp
echo "Cleanup completed at $(date)"