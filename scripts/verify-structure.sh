#!/bin/bash
# verify-structure.sh - Verify project structure is correct

echo "��� VERIFYING PROJECT STRUCTURE"
echo "================================"

# Determine project path
if [ -d "/c/cloud-devops-journey-2026" ]; then
    PROJECT_PATH="/c/cloud-devops-journey-2026"
elif [ -d "/workspaces/cloud-devops-journey-2026" ]; then
    PROJECT_PATH="/workspaces/cloud-devops-journey-2026"
else
    PROJECT_PATH="."
fi

cd "$PROJECT_PATH"

echo "��� Environment: $(pwd)"
echo ""

echo "1. Checking root level folders..."
ROOT_FOLDERS=(".devcontainer" "01-foundation" "02-devops-tools" "03-portfolio-projects" "04-career-prep" "docs" "scripts" "sync" "logs" "backups")
ALL_FOLDERS_OK=true
for folder in "${ROOT_FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        echo "   ✅ $folder exists at root"
    else
        echo "   ❌ $folder MISSING from root"
        ALL_FOLDERS_OK=false
    fi
done

echo ""
echo "2. Checking 04-career-prep content..."
CAREER_FILES=$(find 04-career-prep -maxdepth 1 -type f 2>/dev/null | wc -l)
if [ "$CAREER_FILES" -eq 1 ] && [ -f "04-career-prep/README.md" ]; then
    echo "   ✅ 04-career-prep clean (only README.md)"
else
    echo "   ❌ 04-career-prep has $CAREER_FILES files:"
    ls -la 04-career-prep/ 2>/dev/null || echo "      (cannot access)"
fi

echo ""
echo "3. Checking scripts (must be executable)..."
SCRIPTS=("init-project.sh" "make-executable.sh" "setup-aliases.sh" "sync-environment.sh" "verify-structure.sh")
ALL_SCRIPTS_OK=true
for script in "${SCRIPTS[@]}"; do
    if [ -f "scripts/$script" ]; then
        if [ -x "scripts/$script" ]; then
            echo "   ✅ $script exists and executable"
        else
            echo "   ❌ $script exists but NOT executable (run: chmod +x scripts/$script)"
            ALL_SCRIPTS_OK=false
        fi
    else
        echo "   ❌ $script missing"
        ALL_SCRIPTS_OK=false
    fi
done

echo ""
echo "4. Testing basic functionality..."
# Test git
if command -v git >/dev/null 2>&1; then
    echo "   ✅ Git is available"
    git status --short >/dev/null 2>&1 && echo "   ✅ Git repository accessible" || echo "   ⚠️  Git repo issues"
else
    echo "   ❌ Git not installed"
fi

# Test directory
echo "   ✅ Current directory: $(pwd)"

echo ""
echo "5. ALIAS CHECK NOTE:"
echo "   ⚠️  Aliases cannot be checked in scripts (shell limitation)"
echo "   To check aliases, run manually in terminal:"
echo "     alias gs"
echo "     alias cdproj"
echo "   Or use: ./scripts/test-aliases.sh"

echo ""
echo "================================"
if [ "$ALL_FOLDERS_OK" = true ] && [ "$ALL_SCRIPTS_OK" = true ]; then
    echo "✅ STRUCTURE VERIFIED - PROJECT READY!"
    echo ""
    echo "��� NEXT STEPS:"
    echo "   1. Test aliases manually: 'alias gs'"
    echo "   2. Run: ./scripts/sync-environment.sh"
    echo "   3. Start working in 01-foundation/"
else
    echo "⚠️  STRUCTURE ISSUES - Fix above problems first"
fi
