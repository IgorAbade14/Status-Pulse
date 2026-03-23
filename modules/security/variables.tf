# ======================================================
# SECURITY MODULE INPUTS
# ======================================================

variable "environment" {
  type        = string
  description = "Deployment environment (dev/production)"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID provided by the network module"
}