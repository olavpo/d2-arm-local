#!/bin/bash
# Setup script to create symbolic links for DHIS2 Docker scripts

# Check for required environment variable
if [ -z "$DHIS2_BASE" ]; then
  echo "Error: DHIS2_BASE environment variable not set"
  exit 1
fi

echo "Setting up DHIS2 Docker script symlinks..."

# Create symlinks in /usr/local/bin
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="/usr/local/bin"

# Copy templates to DHIS2_BASE/_templates
echo "Copying templates to $DHIS2_BASE/_templates..."
mkdir -p "$DHIS2_BASE/_templates"
cp -f "$SCRIPT_DIR/_templates/"* "$DHIS2_BASE/_templates/"

# Create symlinks for all d2-* scripts
for script in "$SCRIPT_DIR"/bash-scripts-docker/d2-*; do
  if [ -f "$script" ]; then
    script_name=$(basename "$script")
    echo "Creating symlink: $TARGET_DIR/$script_name -> $script"
    sudo ln -sf "$script" "$TARGET_DIR/$script_name"
  fi
done

echo "✅ Symlinks created successfully!"
echo "You can now run the scripts from anywhere on your system."
echo "Example: d2-info, d2-db-backup, d2-db-restore, etc."
