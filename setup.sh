#!/bin/sh

# Setup script to install the pre-commit hook

REPO_ROOT=$(git rev-parse --show-toplevel)
HOOK_DIR="$REPO_ROOT/.git/hooks"
SCRIPT_SRC="$REPO_ROOT/pre-commit"
SCRIPT_DST="$HOOK_DIR/pre-commit"

echo "Setting up Gitleaks pre-commit hook..."

# Ensure the script is executable
chmod +x "$SCRIPT_SRC"

# Copy (or symlink) the script to .git/hooks
# Symlink is better for keeping it updated with repo changes
ln -sf "$SCRIPT_SRC" "$SCRIPT_DST"

echo "✅ Hook installed to $SCRIPT_DST"
echo "Run 'git config hooks.gitleaks.enable false' to disable it anytime."
