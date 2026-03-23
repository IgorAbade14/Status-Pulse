# ======================================================
# APP MODULE: THE CORE (EC2, DOCKER & S3)
# ======================================================

# 1. EC2 Instance: The server hosting our Status-Pulse Dashboard
resource "aws_instance" "status_pulse_server" {
  ami           = var.ami_ubuntu
  
  # Dynamic selection based on environment (production vs dev)
  instance_type = lookup(var.instance_config, var.environment, "t2.micro")
  
  key_name               = "chave-projeto-abade" # Ensure this key exists in your AWS
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id
  associate_public_ip_address = true

  # BOOTSTRAP: Automating Docker and the Live Dashboard
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu

              # Create the Professional Dashboard File
              cat <<HTML > /home/ubuntu/index.html
              <!DOCTYPE html>
              <html>
              <head>
                  <title>Status-Pulse | Live</title>
                  <meta charset="UTF-8">
                  <style>
                      body { background: #0d1117; color: #c9d1d9; font-family: sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
                      .card { border: 1px solid #30363d; background: #161b22; padding: 2rem; border-radius: 12px; width: 400px; text-align: center; }
                      .status { color: #238636; font-weight: bold; font-size: 1.2rem; margin-bottom: 20px; }
                      #clock { font-size: 2rem; color: #58a6ff; margin: 20px 0; }
                      .env { color: #f0883e; font-size: 0.9rem; text-transform: uppercase; }
                  </style>
              </head>
              <body>
                  <div class="card">
                      <div class="status">● SYSTEM OPERATIONAL</div>
                      <div class="env">Environment: ${var.environment}</div>
                      <div id="clock">00:00:00</div>
                      <div style="font-size: 0.8rem; color: #8b949e;">Status-Pulse v2.0 | Powered by Terraform</div>
                  </div>
                  <script>
                      setInterval(() => {
                          const now = new Date();
                          document.getElementById('clock').innerText = now.toLocaleTimeString();
                      }, 1000);
                  </script>
              </body>
              </html>
              HTML

              # Run Nginx Container with the custom Dashboard
              docker run -d --name web-pulse -p 80:80 -v /home/ubuntu/index.html:/usr/share/nginx/html/index.html nginx:latest
              EOF

  tags = {
    Name        = "status-pulse-server-${var.environment}"
    Project     = "Status-Pulse"
    Environment = var.environment
  }
}

# 2. S3 Bucket: Storage for application assets
resource "aws_s3_bucket" "app_storage" {
  bucket        = var.app_storage_bucket
  force_destroy = true
}

# 3. S3 Versioning: Protection for Production environment
resource "aws_s3_bucket_versioning" "app_storage_versioning" {
  bucket = aws_s3_bucket.app_storage.id
  versioning_configuration {
    status = var.environment == "production" ? "Enabled" : "Suspended"
  }
}

# 4. Local Deployment Log
resource "local_file" "deployment_log" {
  filename = "deployment_summary.txt"
  content  = "Status-Pulse deployed to ${var.environment} at ${timestamp()}"
}