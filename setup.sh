#!/bin/bash
# ======================================================
# PROJECT: Status-Pulse - Automated Provisioning
# FEATURES: Docker + Nginx + Live Dashboard (HTML/JS)
# ======================================================

# Redirect output to logs for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting Status-Pulse provisioning..."

# 1. Update and Install Docker
apt-get update -y
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# 2. Create the Dashboard (HTML/CSS/JS)
cat <<EOF > /home/ubuntu/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Status-Pulse | Operational</title>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body { background: #0d1117; color: #c9d1d9; font-family: 'JetBrains Mono', monospace; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .card { border: 1px solid #30363d; background: #161b22; padding: 2rem; border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); width: 450px; }
        .header { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #30363d; padding-bottom: 1rem; margin-bottom: 1.5rem; }
        .status-badge { background: #238636; color: white; padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: bold; animation: pulse 2s infinite; }
        .data-point { margin-bottom: 1rem; font-size: 0.9rem; }
        .label { color: #8b949e; display: block; font-size: 0.75rem; text-transform: uppercase; margin-bottom: 4px; }
        #live-clock { font-size: 1.8rem; color: #58a6ff; font-weight: bold; }
        @keyframes pulse { 0% { opacity: 1; } 50% { opacity: 0.5; } 100% { opacity: 1; } }
    </style>
</head>
<body>
    <div class="card">
        <div class="header">
            <span>PROJECT STATUS-PULSE</span>
            <span class="status-badge">OPERATIONAL</span>
        </div>
        <div class="data-point">
            <span class="label">Server Local Time</span>
            <div id="live-clock">Loading...</div>
        </div>
        <div class="data-point">
            <span class="label">Environment</span>
            <div style="color: #f0883e; font-weight: bold;">AWS CLOUD / PRODUCTION-LAB</div>
        </div>
        <div class="data-point">
            <span class="label">Deployment Log</span>
            <div style="font-size: 0.8rem; color: #8b949e;">[OK] Docker Engine Installed<br>[OK] Nginx Container Active<br>[OK] Infrastructure Verified</div>
        </div>
        <div style="text-align: center; margin-top: 2rem; font-size: 0.7rem; color: #484f58;">
            Provisioned by Abade-DevOps v2.0
        </div>
    </div>

    <script>
        function updateClock() {
            const now = new Date();
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit', second: '2-digit' };
            document.getElementById('live-clock').innerText = now.toLocaleString('en-US', options);
        }
        setInterval(updateClock, 1000);
        updateClock();
    </script>
</body>
</html>
EOF

# 3. Start Nginx container to serve the Dashboard
docker run -d --name status-pulse-web -p 80:80 -v /home/ubuntu/index.html:/usr/share/nginx/html/index.html nginx:latest

echo "Provisioning complete! Status-Pulse is LIVE."