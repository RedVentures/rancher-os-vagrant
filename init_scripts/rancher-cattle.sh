#!/bin/bash
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce
sudo usermod -aG docker vagrant
sudo systemctl enable docker
sudo systemctl start docker
sudo yum -y install jq


rancher_server_ip="172.19.8.100:8080"
orchestrator="cattle"
curlprefix="appropriate"

while true; do
  ENV_ID=$(docker run \
    -v /tmp:/tmp \
    --rm \
    $curlprefix/curl \
      -sLk \
      "http://$rancher_server_ip/v2-beta/project" | jq '.data[0].id' | tr -d '"')

  if [[ "$ENV_ID" == 1a* ]]; then
    break
  else
    sleep 5
  fi
done


echo Adding host to Rancher Server

docker run \
  -v /tmp:/tmp \
  --rm \
  $curlprefix/curl \
    -sLk \
    -X POST \
    -H 'Content-Type: application/json' \
    -H 'accept: application/json' \
    -d "{\"type\":\"registrationToken\"}" \
      "http://$rancher_server_ip/v2-beta/projects/$ENV_ID/registrationtoken"

docker run \
  -v /tmp:/tmp \
  --rm \
  $curlprefix/curl \
    -sLk \
    "http://$rancher_server_ip/v2-beta/projects/$ENV_ID/registrationtokens/?state=active" |
      jq -r .data[].command |
      head -n1 |
      sh


sudo cp /tmp/docker-compose.yml /tmp/rancher-compose.yml .
sudo curl -LOs 'https://releases.rancher.com/cli/v0.6.12/rancher-linux-amd64-v0.6.12.tar.gz'
sudo tar xvzf rancher-linux-amd64-v0.6.12.tar.gz
sudo mv rancher-v0.6.12/rancher /bin
sudo rancher --url "http://$rancher_server_ip" --env Default up -d --stack load-balancer