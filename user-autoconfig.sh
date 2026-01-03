#!/bin/bash
set -e

# This script runs all the setup scripts located in the user-setup.d/ directory.

if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

for script in "$SCRIPT_DIR"/user-setup.d/*.sh; do
    if [ -f "$script" ]; then
        echo "--- Running $(basename "$script") ---"
        bash "$script" "$1"
        echo ""
    fi
done

echo "--- User setup complete. ---"