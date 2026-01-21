#!/bin/bash

# sync-environment.sh - Sync between Home PC and CodeSpaces

echo "🔄 Starting Environment Sync..."

# Get current timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
BRANCH="main"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Step 1: Check git status
print_status "Step 1: Checking Git status..."
gs_output=$(git status --porcelain)
if [ -n "$gs_output" ]; then
    echo "Changes detected:"
    git status --short
    read -p "Commit these changes? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add .
        git commit -m "sync: $TIMESTAMP - Auto sync changes"
        print_status "Changes committed"
    else
        print_warning "Changes not committed"
    fi
else
    print_status "No uncommitted changes"
fi

# Step 2: Pull latest changes
print_status "Step 2: Pulling latest from $BRANCH..."
if git pull origin $BRANCH; then
    print_status "Pull successful"
else
    print_error "Pull failed. Check for conflicts."
    exit 1
fi

# Step 3: Push changes
print_status "Step 3: Pushing to $BRANCH..."
if git push origin $BRANCH; then
    print_status "Push successful"
else
    print_error "Push failed"
    exit 1
fi

# Step 4: Update sync log
print_status "Step 4: Updating sync log..."
SYNC_LOG="sync/sync-history.md"
if [ ! -f "$SYNC_LOG" ]; then
    echo "# Sync History" > "$SYNC_LOG"
    echo "" >> "$SYNC_LOG"
fi

echo "## $TIMESTAMP" >> "$SYNC_LOG"
echo "- **Branch**: $BRANCH" >> "$SYNC_LOG"
echo "- **Changes**: $(git log --oneline -1 --pretty=format:"%s")" >> "$SYNC_LOG"
echo "- **Commit**: $(git log --oneline -1 --pretty=format:"%h")" >> "$SYNC_LOG"
echo "" >> "$SYNC_LOG"

# Step 5: Update checklist
print_status "Step 5: Updating environment checklist..."
if [ -f "sync/environment-checklist.md" ]; then
    sed -i "s/Last Sync: .*/Last Sync: $TIMESTAMP/" sync/environment-checklist.md
    print_status "Checklist updated"
fi

# Step 6: Display summary
print_status "Step 6: Sync Summary"
echo "==============================="
echo "Timestamp: $TIMESTAMP"
echo "Branch: $BRANCH"
echo "Latest Commit: $(git log --oneline -1 --pretty=format:"%h - %s")"
echo "Uncommitted Changes: $(git status --porcelain | wc -l)"
echo "==============================="

print_status "✅ Environment sync completed!"
echo ""
echo "📋 Quick commands for next steps:"
echo "   gs          - Check git status"
echo "   projstatus  - Full project status"
echo "   envcheck    - Environment check"