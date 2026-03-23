
# ======================================================
# PROJECT: Status-Pulse (Landing Page & Server Monitor)
# OWNER: Abade
# YEAR: 2026
# ======================================================
# 2. Network Module: Creates the foundation (VPC, Subnet, IGW)
module "network" {
  source      = "./modules/network"
  environment = var.environment
}

# 3. Security Module: Creates the Firewall (Security Groups)
# Uses the vpc_id exported from the network module
module "security" {
  source      = "./modules/security"
  environment = var.environment
  vpc_id      = module.network.vpc_id
}

# 4. App Module: The Core (EC2 Instance, Docker, S3)
# Connects everything using IDs from previous modules
module "app" {
  source             = "./modules/app"
  environment        = var.environment
  ami_ubuntu         = var.ami_ubuntu
  instance_config    = var.instance_config
  app_storage_bucket = var.app_storage_bucket
  subnet_id          = module.network.subnet_id
  security_group_id  = module.security.web_sg_id
}

# 5. Final Output: Shows the Public IP to access your Dashboard
output "public_server_ip" {
  description = "The public IP address of your Status-Pulse server"
  value       = module.app.instance_ip
}