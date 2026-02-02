# Terraform EC2 (Ubuntu 24.x + Docker)

This folder is self-contained and separate from the rest of the repo.

## What it creates
- An EC2 instance running the latest Ubuntu 24.04 LTS AMI
- Docker installed via `docker.io`
- GitHub CLI (`gh`) installed
- Apache HTTPD (`apache2`) installed and started
- An imported SSH key from your local `~/.ssh/id_ed25519.pub`
- A security group that allows only port 22 from your current IP
- Optional clone of a repo you specify

## Usage
1) Provide your AWS region and current public IP (as /32).
2) Run Terraform.

Example:
```bash
cd terraform-ec2
terraform init
terraform apply \
  -var "aws_region=us-east-1" \
  -var "allowed_ssh_cidr=203.0.113.10/32" \
  -var "repo_url=git@github.com:YOUR_ORG/YOUR_REPO.git"
```

## Notes
- This uses the default VPC and first subnet in that VPC.
- If you want a different subnet/VPC or to manage networking explicitly, say the word.
