#!/bin/bash

sudo wget https://go.dev/dl/go1.17.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.17.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
sudo apt-get install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo systemctl restart docker
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins




#sudo su 
#echo -e '{\n  "insecure-registries" : ["ubuntu-bionic:8082"]\n}' > /etc/docker/daemon.json
#echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile
#echo -e "192.168.56.10\tubuntu-bionic\tubuntu-bionic" >> /etc/hosts
#exit
#sudo docker run -d -p 8081:8081 -p 8082:8082 --name nexus -e INSTALL4J_ADD_VM_PARAMS="-Xms512m -Xmx512m -XX:MaxDirectMemorySize=273m" sonatype/nexus3
#sudo systemctl restart docker