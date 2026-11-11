
# Config Generator with Validation

## Overview

A Bash-based configuration generator that creates application configuration files using environment variables.

The script validates required variables, applies default values to optional variables, and generates a structured configuration file.

## Project Structure

```text
02-config-generator-validation/
├── scripts/
│   └── genconfig.sh
├── examples/
│   └── config.env.example
└── README.md
```

## Requirements

- Linux environment
- Bash
- Environment variables

## Configuration Variables

| Variable | Required | Default |
|---|---|---|
| APP_NAME | Yes | None |
| APP_PORT | Yes | None |
| APP_ENV | No | production |
| LOG_LEVEL | No | info |

## Usage

Make the script executable:

```bash
chmod +x scripts/genconfig.sh
```

Run with required variables:

```bash
APP_NAME=web APP_PORT=8080 \
./scripts/genconfig.sh config.env
```

Run with custom optional variables:

```bash
APP_NAME=web APP_PORT=3000 \
APP_ENV=development LOG_LEVEL=debug \
./scripts/genconfig.sh config.env
```

## Expected Output

```ini
APP_NAME=web
APP_PORT=8080
APP_ENV=production
LOG_LEVEL=info
```

## Validation

The script checks:

- Exactly one output path argument is provided.
- APP_NAME is present.
- APP_PORT is present.
- Optional variables receive default values.
- Configuration is written only after required-value validation.

## Bash Concepts Practiced

- Strict mode: set -euo pipefail
- Environment variables
- Positional arguments
- Parameter expansion
- Input validation
- Default values
- Output redirection
- Exit status and error handling

## Author

Yugesh Pathivada
