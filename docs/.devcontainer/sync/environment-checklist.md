# Environment Sync Checklist

## Tools Required
- [ ] Git
- [ ] AWS CLI v2
- [ ] Terraform
- [ ] Docker
- [ ] VS Code Extensions:
  - [ ] Terraform
  - [ ] Docker
  - [ ] GitHub Actions

## Verification Commands
```bash
# Check installations
aws --version
git --version
terraform version
docker --version

# Check VS Code extensions
code --list-extensions | grep -E "terraform|docker|github"
