# ======================================================
# STATUS-PULSE: INFRASTRUCTURE CONNECTION & STATE
# ======================================================

terraform {
  # Ensures you are using a modern version of Terraform
  required_version = ">= 1.0.0"

  # BACKEND (REMOTE STATE): 
  # Uncomment this when you are ready to move from local to AWS S3 storage.
  # backend "s3" {
  #   bucket  = "status-pulse-terraform-state-2026" # Updated bucket name
  #   key     = "production/terraform.tfstate"
  #   region  = "us-east-1"
  #   encrypt = true
  # }
}

# Provider AWS: The 'bridge' between your code and Amazon's Cloud
provider "aws" {
  region = var.aws_region # Using the new English variable name
}