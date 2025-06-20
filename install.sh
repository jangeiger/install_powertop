#!/usr/bin/env bash

echo "Step 1: Installing apt packages"

sudo apt update
sudo apt install -y curl vim ca-certificates

echo "Step 2: Install docker"

# Add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo get update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin



# Tutorial: https://powerapi.org/reference/formulas/smartwatts/
echo "Step 3: Pull powerapi docker image"
sudo docker pull ghcr.io/powerapi-ng/smartwatts-formula

echo "Step 4: Setup mongoDB in docker"
docker run -d --name mongo_source -p 27017:27017 mongo

echo "Step 5: Setup influxDB"

docker run -p 8086:8086 -v "/tmp/powerapi-influx/data:/var/lib/influxdb2" -v "/tmp/powerapi-influx/config:/etc/influxdb2" influxdb:2

