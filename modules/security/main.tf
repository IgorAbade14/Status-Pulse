# ======================================================
# SECURITY MODULE: FIREWALL RULES (SECURITY GROUPS)
# ======================================================

resource "aws_security_group" "web_access_sg" {
  name        = "status-pulse-web-sg-${var.environment}"
  description = "Allow SSH and HTTP traffic for Status-Pulse Dashboard"
  vpc_id      = var.vpc_id # Received from the network module via root

  # 1. INBOUND (Ingress): SSH Access
  # Allows you to connect to the server terminal
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open for dev - restrict in strict production
  }

  # 2. INBOUND (Ingress): HTTP Web Traffic
  # Allows the world to see your Live Dashboard/Nginx
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 3. OUTBOUND (Egress): Full Access
  # Allows the server to download updates and Docker images
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # "-1" means ALL protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { 
    Name        = "sg-status-pulse-${var.environment}"
    Project     = "Status-Pulse"
    Environment = var.environment
  }
}