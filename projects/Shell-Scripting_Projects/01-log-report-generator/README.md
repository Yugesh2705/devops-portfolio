
# Log Report Generator

A reusable Bash script that analyzes web server access logs and generates a summary report.

## Features

- Counts total HTTP requests.
- Identifies the busiest client IP.
- Counts HTTP error responses (status codes >= 400).
- Groups requests by URL path.
- Validates command-line arguments.
- Handles missing input files.
- Creates output directories automatically.
- Uses strict Bash mode (set -euo pipefail).

## Project Structure

```text
log-report-generator/
├── scripts/
│   └── logreport.sh
├── examples/
│   ├── access.log
│   └── report.txt
├── README.md
└── .gitignore
```

## Requirements

- Linux
- Bash
- AWK

## Usage

```bash
./scripts/logreport.sh <input-log> <output-report>
```

Example:

```bash
./scripts/logreport.sh examples/access.log examples/report.txt
```

## Sample Output

```text
total requests: 8
top IP: 10.0.0.5 (4)
error responses: 3
/api/users: 3
/api/login: 2
/api/products: 2
/api/orders: 1
```

## Concepts Practiced

- Bash scripting
- Positional arguments
- Conditional statements
- Exit codes
- Strict mode
- Input/output redirection
- AWK associative arrays
- Log processing
- Linux automation
