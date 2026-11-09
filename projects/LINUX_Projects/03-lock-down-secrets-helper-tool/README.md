# Project 03: Lock Down Secrets and a Helper Tool

## Overview

This project demonstrates Linux server security hardening through file permission management, SSH key protection, persistent PATH configuration, symbolic links, and Bash aliases.

The objective is to secure sensitive application files and SSH credentials while making a deployment helper executable globally through a simple command.

## Objectives

- Secure application secrets using Linux file permissions.
- Restrict access to SSH private keys.
- Configure appropriate permissions for public SSH keys.
- Protect the SSH directory from unauthorized access.
- Create a globally accessible deployment helper command.
- Configure persistent environment variables through `.bashrc`.
- Create Bash aliases to simplify command execution.
- Automate server configuration using Bash scripting.

## Technologies and Tools

- Linux
- Bash scripting
- chmod
- ls and stat
- ln (symbolic links)
- PATH environment variable
- grep
- sed
- install
- SSH key permissions

## Project Structure

```text
03-lock-down-secrets-helper-tool/
│
├── README.md
│
└── scripts/
    ├── secure-server.sh
    └── deploy-helper.sh
```

## 1. Application Secrets Protection

File:

`/root/app/secrets.env`

Command:

```bash
chmod 600 /root/app/secrets.env
```

Permission breakdown:

| User category | Permissions |
|---|---|
| Owner | Read, Write |
| Group | None |
| Others | None |

This prevents other local users from reading sensitive application configuration.

## 2. SSH Key Protection

Commands:

```bash
chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/id_rsa.pub
```

Permission breakdown:

| Resource | Mode | Purpose |
|---|---:|---|
| `.ssh` directory | 700 | Owner-only access |
| Private key | 600 | Owner read/write |
| Public key | 644 | Publicly readable |

Private SSH keys must never be accessible to unauthorized users.

## 3. Global Deployment Helper

Original helper:

`/root/tools/deploy-helper.sh`

Create a symbolic link:

```bash
mkdir -p /root/bin

ln -sfn /root/tools/deploy-helper.sh \
/root/bin/deploy-helper
```

This allows the helper to execute using:

```bash
deploy-helper
```

## 4. Persistent PATH Configuration

Add the following to the beginning of `/root/.bashrc`:

```bash
export PATH="$HOME/bin:$PATH"
```

This makes the deployment helper discoverable through PATH in new Bash shells.

## 5. Bash Alias Configuration

Add the following to `/root/.bashrc`:

```bash
alias deploy='deploy-helper'
```

Now the helper can also be executed using:

```bash
deploy
```

## 6. Verification

Verify file permissions:

```bash
stat -c "%a %n" \
/root/app/secrets.env \
/root/.ssh \
/root/.ssh/id_rsa \
/root/.ssh/id_rsa.pub
```

Expected output:

```text
600 /root/app/secrets.env
700 /root/.ssh
600 /root/.ssh/id_rsa
644 /root/.ssh/id_rsa.pub
```

Verify helper availability in a new login shell:

```bash
bash --login -c 'command -v deploy-helper'
```

Verify execution:

```bash
bash --login -c 'deploy-helper'
```

Verify alias:

```bash
alias deploy
```

## 7. Automation

The `secure-server.sh` script automates:

1. Validation of required files.
2. Application secrets permission hardening.
3. SSH directory and key permission hardening.
4. Deployment helper installation.
5. Symbolic link creation.
6. Persistent PATH configuration.
7. Bash alias configuration.

Run as root after the required files have been provisioned:

```bash
bash scripts/secure-server.sh
```

## Real-World Applications

These practices are useful in:

- Linux server administration.
- Production server hardening.
- DevOps automation.
- SSH authentication management.
- Deployment tooling.
- Secure application configuration management.

## Skills Demonstrated

- Linux file permissions and ownership concepts.
- SSH security fundamentals.
- Bash scripting and automation.
- Environment variable configuration.
- Symbolic link management.
- Shell initialization and configuration.
- Idempotent configuration techniques.

## Security Considerations

- Never commit real passwords, API tokens, or private SSH keys to GitHub.
- Use appropriate file permissions for sensitive configuration.
- Keep private keys restricted to their authorized owner.
- Avoid unnecessary modifications to existing shell configurations.

---

**Project Category:** Linux Administration / DevOps  
**Project Number:** 03  
**Status:** Completed in Linux lab