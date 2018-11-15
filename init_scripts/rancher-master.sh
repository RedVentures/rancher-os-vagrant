#!/bin/bash
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce
sudo usermod -aG docker vagrant
sudo systemctl enable docker
sudo systemctl start docker
sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server