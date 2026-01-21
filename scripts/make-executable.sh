#!/bin/bash

# make-executable.sh - Make all scripts executable

echo "🔧 Setting script permissions..."

# Make all .sh files executable
find ./scripts -name "*.sh" -type f -exec chmod +x {} \;

# List scripts with their permissions
echo "📋 Available scripts:"
ls -la scripts/*.sh

echo ""
echo "✅ Scripts are now executable!"
echo "📋 Usage:"
echo "   ./scripts/setup-aliases.sh    - Setup git aliases"
echo "   ./scripts/init-project.sh     - Initialize project"
echo "   ./scripts/sync-environment.sh - Sync environments"
echo "   ./scripts/make-executable.sh  - Make scripts executable (this)"