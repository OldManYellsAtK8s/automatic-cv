variable "aws_region" {
  type        = string
  description = "AWS region to deploy into"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "instance_name" {
  type        = string
  description = "Name tag for the EC2 instance"
  default     = "ubuntu-24-docker"
}

variable "key_pair_name" {
  type        = string
  description = "Name for the imported SSH key pair"
  default     = "local-ed25519"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to your SSH public key"
  default     = "~/.ssh/id_ed25519.pub"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "Single IP in CIDR notation allowed to SSH (e.g., 203.0.113.10/32)"
}

variable "security_group_name" {
  type        = string
  description = "Security group name"
  default     = "ssh-only"
}

variable "repo_url" {
  type        = string
  description = "Git URL to clone on the instance (leave empty to skip)"
  default     = ""
}

variable "repo_dir" {
  type        = string
  description = "Directory to clone repo into"
  default     = "/opt/parent-repo"
}
