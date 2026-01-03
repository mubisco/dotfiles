#!/bin/bash
set -e

# Install vscode-php-debug for DAP
INSTALL_DIR="$HOME/.local/share/vscode-php-debug"

echo "Installing PHP Debugger (vscode-php-debug)..."

if [ ! -d "$INSTALL_DIR" ]; then
    echo "Cloning vscode-php-debug into $INSTALL_DIR..."
    git clone https://github.com/xdebug/vscode-php-debug.git "$INSTALL_DIR"
else
    echo "vscode-php-debug already exists. Pulling latest changes..."
    cd "$INSTALL_DIR" || exit
    git pull
fi

cd "$INSTALL_DIR" || exit

echo "Building vscode-php-debug..."
# Check if npm is available (it should be installed via autoconfig.sh)
if command -v npm &> /dev/null; then
    npm install && npm run build
    echo "PHP Debugger installed successfully."
else
    echo "Error: npm is not installed. Skipping build."
fi
