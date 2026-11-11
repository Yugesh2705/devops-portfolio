
#!/usr/bin/env bash
set -euo pipefail

# Validate command-line argument
if [ "$#" -ne 1 ]; then
  echo "usage: $(basename "$0") <output-path>" >&2
  exit 1
fi

# Get output file path
out=$1

# Validate required environment variables
: "${APP_NAME:?APP_NAME is required}"
: "${APP_PORT:?APP_PORT is required}"

# Set defaults for optional variables
APP_ENV=${APP_ENV:-production}
LOG_LEVEL=${LOG_LEVEL:-info}

# Generate configuration file
{
  echo "APP_NAME=$APP_NAME"
  echo "APP_PORT=$APP_PORT"
  echo "APP_ENV=$APP_ENV"
  echo "LOG_LEVEL=$LOG_LEVEL"
} > "$out"
