#!/bin/bash

# Step 1: Generate SSH key in Jenkins container if not exists
docker exec -u 0 jenkins-container bash -c '[[ -f /root/.ssh/id_rsa ]] || ssh-keygen -t rsa -q -N "" -f /root/.ssh/id_rsa'

# Step 2: Copy public key from Jenkins container
PUB_KEY=$(docker exec -u 0 jenkins-container cat /root/.ssh/id_rsa.pub)

# Step 3: Create .ssh folder in Ubuntu container
docker exec -u 0 ubuntu-ssh-container mkdir -p /root/.ssh
docker exec -u 0 ubuntu-ssh-container bash -c "echo '$PUB_KEY' >> /root/.ssh/authorized_keys"
docker exec  -u 0 ubuntu-ssh-container chmod 600 /root/.ssh/authorized_keys
docker exec  -u 0 ubuntu-ssh-container chmod 700 /root/.ssh

echo "✅ SSH key copied. You can now SSH from Jenkins to Ubuntu."
