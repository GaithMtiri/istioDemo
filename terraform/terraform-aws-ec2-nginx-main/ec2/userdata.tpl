#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo hostnamectl set-hostname minikube
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo apt-get update -y &&  sudo apt-get install -y docker.io
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
snap install kubectl --classic
sudo apt install conntrack -y



#### install cri-dockerd
git clone https://github.com/Mirantis/cri-dockerd.git
# Run these commands as root
###Install GO###
# wget https://storage.googleapis.com/golang/getgo/installer_linux
# chmod +x ./installer_linux
# ./installer_linux
# source ~/.bash_profile
cd /cri-dockerd
mkdir bin 
export GOCACHE=/root/go/cache
sudo snap install go --classic
go build -o bin/cri-dockerd
mkdir -p /usr/local/bin
install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
cp -a packaging/systemd/* /etc/systemd/system
sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
systemctl daemon-reload
systemctl enable cri-docker.service
systemctl enable --now cri-docker.socket
sudo sysctl fs.protected_regular=0

VERSION="v1.24.1"
wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
sudo tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
rm -f crictl-$VERSION-linux-amd64.tar.gz


