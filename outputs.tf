# ======================================================
# DEPLOYMENT SUMMARY (FINAL RECEIPT)
# ======================================================

# 1. App Storage URL: Direct link to your S3 bucket assets
output "storage_bucket_url" {
  description = "DNS address of the S3 bucket created in the app module"
  value       = module.app.bucket_url
}

# 2. Server Access IP: The most important data for HTTP/SSH access
output "server_public_ip" {
  description = "Public IP to access the Status-Pulse Dashboard"
  value       = module.app.instance_ip
}

# 3. Environment Status: Confirmation of the current deployment logic
output "deployment_status_message" {
  description = "Message generated based on the environment logic"
  value       = module.app.deployment_log_content
}

# 4. Infrastructure Audit: Shows exactly what hardware was provisioned
output "provisioned_instance_type" {
  description = "EC2 type selected via lookup based on environment"
  value       = lookup(var.instance_config, var.environment, "t2.micro")
}