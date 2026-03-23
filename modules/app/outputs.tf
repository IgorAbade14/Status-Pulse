# ======================================================
# APP MODULE EXPORTS
# ======================================================

output "bucket_id" {
  value = aws_s3_bucket.app_storage.id
}

output "bucket_url" {
  value = aws_s3_bucket.app_storage.bucket_domain_name
}

output "instance_ip" {
  description = "The public IP to access the Dashboard"
  value       = aws_instance.status_pulse_server.public_ip
}

output "deployment_log_content" {
  value = local_file.deployment_log.content
}