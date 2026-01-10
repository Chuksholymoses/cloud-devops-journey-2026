#!/bin/bash
echo "🔍 Checking Environment Tools..."

echo "1. Git:"
git --version

echo "2. AWS CLI:"
aws --version 2>/dev/null || echo "AWS CLI not installed"

echo "3. Terraform:"
terraform version 2>/dev/null || echo "Terraform not installed"

echo "4. Docker:"
docker --version 2>/dev/null || echo "Docker not installed"

echo "📊 Status: Environment check completed"