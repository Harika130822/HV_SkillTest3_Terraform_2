#!/bin/bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y nginx

cat > /var/www/html/index.html <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Terraform-managed Nginx Server</title>
</head>
<body>
  <h1>Welcome to the Terraform-managed Nginx Server on Ubuntu</h1>
</body>
</html>
HTML

systemctl enable --now nginx
