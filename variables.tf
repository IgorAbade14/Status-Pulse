# ======================================================
# STATUS-PULSE: PROJECT VARIABLES (THE BRAIN)
# ======================================================

# 1. AWS Region: Where resources will be created
variable "aws_region" {
  description = "AWS Region (e.g., us-east-1)"
  type        = string
  default     = "us-east-1"
}

# 2. Environment Switch: Controls the project logic
# Valid options: "production" or "dev"
variable "environment" {
  description = "Deployment environment (production or dev)"
  type        = string
  default     = "dev"
}

# 3. S3 Bucket Name: Must be globally unique
variable "app_storage_bucket" {
  description = "Unique name for the application S3 bucket"
  type        = string
  default     = "status-pulse-assets-abade-2026"
}

# 4. Hardware Map: Selects instance power based on environment
variable "instance_config" {
  description = "Map of EC2 instance types per environment"
  type        = map(string)
  default = {
    "production" = "t3.medium"
    "dev"        = "t3.micro"
  }
}

# 5. OS Image (AMI): Ubuntu 22.04 LTS ID
variable "ami_ubuntu" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}