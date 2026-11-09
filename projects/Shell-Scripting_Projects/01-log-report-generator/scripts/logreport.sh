
#!/bin/bash

set -euo pipefail

# Validate arguments
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <input-log> <output-report>" >&2
    exit 2
fi

input="$1"
output="$2"

# Validate input file
if [[ ! -f "$input" ]]; then
    echo "Error: Input log file does not exist: $input" >&2
    exit 1
fi

# Create output directory if missing
mkdir -p "$(dirname "$output")"

# Generate report
awk '
{
    total++
    ip_count[$1]++
    path_count[$3]++

    if ($4 >= 400) {
        errors++
    }
}

END {
    print "total requests: " total

    max = 0
    top_ip = ""

    for (ip in ip_count) {
        if (ip_count[ip] > max ||
            (ip_count[ip] == max && (top_ip == "" || ip < top_ip))) {
            max = ip_count[ip]
            top_ip = ip
        }
    }

    if (top_ip == "") {
        print "top IP: none (0)"
    } else {
        print "top IP: " top_ip " (" max ")"
    }

    print "error responses: " errors

    for (path in path_count) {
        print path ": " path_count[path]
    }
}
' "$input" > "$output"
