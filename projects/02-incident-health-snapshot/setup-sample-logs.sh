#!/bin/bash

# Create sample application logs

LOG_DIR="/var/log/escbash-app"

sudo mkdir -p "$LOG_DIR"

echo "service started" | sudo tee "$LOG_DIR/app.log" > /dev/null
echo "request handled" | sudo tee -a "$LOG_DIR/app.log" > /dev/null
echo "request handled" | sudo tee -a "$LOG_DIR/app.log" > /dev/null

echo "Sample application logs created successfully."
