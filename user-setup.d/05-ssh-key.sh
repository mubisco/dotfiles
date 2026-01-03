#!/bin/bash
set -e

# Generate SSH key if it doesn't exist
SSH_KEY_PATH="$HOME/.ssh/id_ed25519"

if [ ! -f "$SSH_KEY_PATH" ]; then
    echo "Generating SSH key (ed25519) with no passphrase..."
    ssh-keygen -t ed25519 -N "" -f "$SSH_KEY_PATH"
    echo "SSH key generated at $SSH_KEY_PATH"
else
    echo "SSH key already exists at $SSH_KEY_PATH. Skipping generation."
fi
