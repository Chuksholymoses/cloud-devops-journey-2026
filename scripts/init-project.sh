#!/bin/bash

# init-project.sh - Initialize and verify project structure

echo "🚀 Initializing Cloud DevOps Project Structure..."

# Navigate to project root
cd /c/cloud-devops-journey-2026

echo "📁 Creating directory structure..."

# Create all required directories
mkdir -p 01-foundation 02-devops-tools 03-portfolio-projects 04-career-prep
mkdir -p docs scripts sync logs backups

echo "📝 Creating README files..."

# Create README files with templates
for dir in 01-foundation 02-devops-tools 03-portfolio-projects 04-career-prep; do
    if [ ! -f "$dir/README.md" ]; then
        cat > "$dir/README.md" << EOF
# $(echo $dir | sed 's/[0-9]*-//' | tr '-' ' ' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')

## Overview
This module is part of the Cloud DevOps Journey 2026.

## Goals
- [ ] Goal 1
- [ ] Goal 2
- [ ] Goal 3

## Progress
- **Started**: $(date +%Y-%m-%d)
- **Last Updated**: $(date +%Y-%m-%d)
- **Status**: Not Started

## Notes
Add your notes here...

---
*Part of cloud-devops-journey-2026*
EOF
        echo "  ✅ Created $dir/README.md"
    fi
done

echo "📋 Creating documentation files..."

# Create daily log template if doesn't exist
if [ ! -f "docs/daily-learning-log.md" ]; then
    cat > "docs/daily-learning-log.md" << 'EOF'
# Daily Learning Log

## $(date +%Y-%m-%d)

### 🎯 Today's Goals
- [ ] Goal 1
- [ ] Goal 2

### 📚 What I Learned
1. 
2. 

### 💻 Work Done
- 

### 🚧 Challenges
- 

### ✅ Achievements
- 

### 🔮 Tomorrow's Plan
- 

### 📝 Notes
- 

---
*Template for daily tracking*
EOF
    echo "  ✅ Created docs/daily-learning-log.md"
fi

# Create sync checklist if doesn't exist
if [ ! -f "sync/environment-checklist.md" ]; then
    cat > "sync/environment-checklist.md" << 'EOF'
# Environment Sync Checklist

## Daily Startup
- [ ] Open VS Code
- [ ] Run `cdproj` (navigate to project)
- [ ] Run `gl` (pull latest changes)
- [ ] Open learning log

## During Work
- [ ] Use `gs` frequently
- [ ] Commit with descriptive messages
- [ ] Push completed work

## Before Switching/Closing
- [ ] Run `gsync` (pull + push)
- [ ] Verify no conflicts
- [ ] Update learning log

## Structure Verification
- [ ] No duplicate files/folders
- [ ] All project folders (01-04) exist
- [ ] Scripts folder has latest scripts
- [ ] Docs folder updated

## Last Sync: $(date +%Y-%m-%d %H:%M)
EOF
    echo "  ✅ Created sync/environment-checklist.md"
fi

echo "🔍 Verifying structure..."

# Verify structure
echo "=== Current Structure ==="
ls -la
echo ""
echo "=== Project Folders ==="
ls -d */
echo ""
echo "=== File Count ==="
find . -type f -name "*.md" | wc -l | xargs echo "Markdown files:"
find . -type f -name "*.sh" | wc -l | xargs echo "Script files:"

echo ""
echo "✅ Project initialization complete!"
echo "📋 Next steps:"
echo "   1. Review the structure above"
echo "   2. Run 'source scripts/setup-aliases.sh' to setup aliases"
echo "   3. Start working in the appropriate module"