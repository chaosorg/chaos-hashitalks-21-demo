#!/bin/bash
yum update -y
amazon-linux-extras install -y
echo "Staring k0s installation"
curl -L https://github.com/k0sproject/k0s/releases/download/v0.10.0/k0s-v0.10.0-amd64 --output k0s
chmod +x k0s
mv k0s /usr/bin/k0s
k0s default-config  > default.yaml 
k0s install server -c default.yaml
systemctl daemon-reload
service k0sserver.service start
service k0sserver.service status
echo "Ending k0s installation"