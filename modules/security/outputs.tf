# ======================================================
# SECURITY MODULE EXPORTS
# ======================================================

# Exported to the APP module to be attached to the EC2 instance
output "web_sg_id" {
  description = "The ID of the Security Group for Web/SSH access"
  value       = aws_security_group.web_access_sg.id
}