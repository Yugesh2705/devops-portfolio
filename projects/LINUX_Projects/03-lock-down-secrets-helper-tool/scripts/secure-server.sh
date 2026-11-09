#!/usr/bin/env bash

set -euo pipefail

# Ensure the script runs as root
if [[ "$EUID" -ne 0 ]]; then
    echo "Error: Run this script as root."
    exit 1
fi

echo "Starting server security configuration..."

# Define paths
SECRETS="/root/app/secrets.env"
SSH_DIR="/root/.ssh"
PRIVATE_KEY="$SSH_DIR/id_rsa"
PUBLIC_KEY="$SSH_DIR/id_rsa.pub"
TOOLS_DIR="/root/tools"
BIN_DIR="/root/bin"
BASHRC="/root/.bashrc"

# Verify required files exist
for file in "$SECRETS" "$PRIVATE_KEY" "$PUBLIC_KEY"; do
    if [[ ! -f "$file" ]]; then
        echo "Error: Required file missing: $file"
        exit 1
    fi
done

# Secure application secrets
chmod 600 "$SECRETS"

# Secure SSH directory and key material
chmod 700 "$SSH_DIR"
chmod 600 "$PRIVATE_KEY"
chmod 644 "$PUBLIC_KEY"

echo "File permissions secured."

# Install deploy helper
mkdir -p "$TOOLS_DIR" "$BIN_DIR"

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

install -m 755 "$SCRIPT_DIR/deploy-helper.sh" \
    "$TOOLS_DIR/deploy-helper.sh"

# Create command without .sh extension
ln -sfn "$TOOLS_DIR/deploy-helper.sh" \
    "$BIN_DIR/deploy-helper"

echo "Deploy helper installed."

# Configure persistent PATH
touch "$BASHRC"

PATH_LINE='export PATH="$HOME/bin:$PATH"'

if ! grep -qxF "$PATH_LINE" "$BASHRC"; then
    sed -i "1i $PATH_LINE" "$BASHRC"
fi

# Configure deploy alias
ALIAS_LINE="alias deploy='deploy-helper'"

if ! grep -qE '^[[:space:]]*alias deploy=' "$BASHRC"; then
    printf '\n%s\n' "$ALIAS_LINE" >> "$BASHRC"
fi

echo "Bash configuration updated."

echo "Server security configuration completed."