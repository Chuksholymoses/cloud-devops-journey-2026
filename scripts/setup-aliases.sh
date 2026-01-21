#!/bin/bash

# setup-aliases.sh - Automatically configure Git and DevOps aliases

echo "🔧 Setting up DevOps Aliases..."

# Backup existing .bashrc
if [ -f ~/.bashrc ]; then
    cp ~/.bashrc ~/.bashrc.backup.$(date +%Y%m%d)
    echo "📁 Backed up .bashrc to ~/.bashrc.backup.$(date +%Y%m%d)"
fi

# Check if aliases already exist
if grep -q "GIT ALIASES FOR DEVOPS WORKFLOW" ~/.bashrc; then
    echo "⚠️  Aliases already exist. Updating..."
    # Remove old alias section
    sed -i '/# ===== GIT ALIASES FOR DEVOPS WORKFLOW =====/,/# ===== END DEVOPS ALIASES =====/d' ~/.bashrc
fi

# Add new alias section
cat >> ~/.bashrc << 'EOF'

# ===== GIT ALIASES FOR DEVOPS WORKFLOW =====
# Basic git shortcuts
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push origin main'
alias gl='git pull origin main'
alias gco='git checkout'
alias gb='git branch'

# DevOps workflow specific
alias gsync='git pull origin main && git push origin main'
alias gfix='git add . && git commit -m "fix: quick fix" && git push origin main'
alias gupdate='git add . && git commit -m "update: sync changes" && git push origin main'
alias gclean='git fetch --prune && git branch --merged | grep -v "\\*\\|main" | xargs -n 1 git branch -d'

# Folder navigation (for cloud-devops project)
alias cdproj='cd /c/cloud-devops-journey-2026'
alias cddocs='cd /c/cloud-devops-journey-2026/docs'
alias cdsync='cd /c/cloud-devops-journey-2026/sync'
alias cdscripts='cd /c/cloud-devops-journey-2026/scripts'
alias cd1='cd /c/cloud-devops-journey-2026/01-foundation'
alias cd2='cd /c/cloud-devops-journey-2026/02-devops-tools'
alias cd3='cd /c/cloud-devops-journey-2026/03-portfolio-projects'
alias cd4='cd /c/cloud-devops-journey-2026/04-career-prep'

# Quick system commands
alias ll='ls -la'
alias lh='ls -lah'
alias tree='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'

# Project status
alias projstatus='echo "=== Project Status ===" && gs && echo "" && echo "=== Structure ===" && ls -la'

# Environment check
alias envcheck='echo "🔄 Checking environment..." && cdproj && gs && echo "✅ Project accessible"'
# ===== END DEVOPS ALIASES =====
EOF

# Reload .bashrc
source ~/.bashrc

echo "✅ Aliases installed successfully!"
echo "📋 Available commands:"
echo "   gs, ga, gc, gp, gl, gsync, gfix, gupdate"
echo "   cdproj, cd1-cd4, cddocs, cdsync"
echo "   projstatus, envcheck"
echo ""
echo "💡 Run 'source ~/.bashrc' in any open terminals or restart terminal"