#!/bin/bash
echo "🚀 Setting up Cloud DevOps Environment..."

echo "1. Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/

echo "2. Installing Terraform..."
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6_0_linux_amd64.zip
unzip terraform_1.6_0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_1.6_0_linux_amd64.zip

echo "3. Installing Docker..."
sudo apt-get update
sudo apt-get install -y docker.io

echo "✅ Setup complete!"
echo "📝 Next: Run 'aws configure' to add your credentials"