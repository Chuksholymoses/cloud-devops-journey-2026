#!/bin/bash
# verify-structure.sh - Verify project structure is correct

echo "��� VERIFYING PROJECT STRUCTURE"
echo "================================"

cd /c/cloud-devops-journey-2026

echo "1. Checking root level folders..."
ROOT_FOLDERS=(".devcontainer" "01-foundation" "02-devops-tools" "03-portfolio-projects" "04-career-prep" "docs" "scripts" "sync" "logs" "backups")
for folder in "${ROOT_FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        echo "   ✅ $folder exists at root"
    else
        echo "   ❌ $folder MISSING from root"
    fi
done

echo ""
echo "2. Checking 04-career-prep content..."
CAREER_ITEMS=$(find 04-career-prep/ -maxdepth 1 -type f | wc -l)
if [ "$CAREER_ITEMS" -eq 1 ]; then  # Only README.md
    echo "   ✅ 04-career-prep clean (only README.md)"
else
    echo "   ❌ 04-career-prep has extra items:"
    ls -la 04-career-prep/
fi

echo ""
echo "3. Checking scripts..."
SCRIPTS=("init-project.sh" "make-executable.sh" "setup-aliases.sh" "sync-environment.sh" "verify-structure.sh")
for script in "${SCRIPTS[@]}"; do
    if [ -f "scripts/$script" ]; then
        if [ -x "scripts/$script" ]; then
            echo "   ✅ $script exists and executable"
        else
            echo "   ⚠️ $script exists but NOT executable"
        fi
    else
        echo "   ❌ $script missing"
    fi
done

echo ""
echo "4. Testing aliases..."
# Use 'command -v' instead of 'type' for better compatibility
if command -v gs &> /dev/null; then
    echo "   ✅ gs alias works"
else
    echo "   ❌ gs alias missing"
fi

if command -v cdproj &> /dev/null; then
    echo "   ✅ cdproj alias works"
else
    echo "   ❌ cdproj alias missing"
fi

echo ""
echo "================================"
echo "✅ VERIFICATION COMPLETE"
