#!/bin/bash
yum update -y
amazon-linux-extras install -y
echo "Staring k0s installation"
curl -L https://github.com/k0sproject/k0s/releases/download/v0.10.0/k0s-v0.10.0-amd64 --output k0s
chmod +x k0s
mv k0s /usr/bin/k0s
k0s default-config  > /home/ec2-user/default.yaml 
k0s install server -c /home/ec2-user/default.yaml
systemctl daemon-reload
service k0sserver.service start
service k0sserver.service status
sleep 10
k0s token create --role=worker > /tmp/token-worker.txt
echo "Ending k0s installation"

echo "Creating kubeconfig"
mkdir /home/ec2-user/.kube
k0s kubeconfig create --groups "system:masters" chaos > /home/ec2-user/.kube/config
chown -R ec2-user:ec2-user /home/ec2-user/.kube
kubectl create clusterrolebinding chaos-admin-binding --clusterrole=admin --user=chaos
echo "Ending kubeconfig"


echo "Starting kubectl installation"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version
echo "Ending kubectl installation"