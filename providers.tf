# ======================================================
# STATUS-PULSE: INFRASTRUCTURE CONNECTION & STATE
# ======================================================

terraform {
  # Ensures you are using a modern version of Terraform
  required_version = ">= 1.0.0"
}

#  backend "s3" {
#    bucket  = "status-pulse-assets-abade-2026" # Updated bucket name
#    key     = "production/terraform.tfstate"
#    region  = "us-east-1"
#    encrypt = true
# }
#}

# Provider AWS: The 'bridge' between your code and Amazon's Cloud
provider "aws" {
  region = var.aws_region # Using the new English variable name
}