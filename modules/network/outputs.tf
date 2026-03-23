# ======================================================
# NETWORK MODULE EXPORTS
# ======================================================

# Exported to the SECURITY module
output "vpc_id" {
  description = "The ID of the Status-Pulse VPC"
  value       = aws_vpc.status_pulse_vpc.id
}

# Exported to the APP module
output "subnet_id" {
  description = "The ID of the Public Subnet"
  value       = aws_subnet.status_pulse_subnet.id
}