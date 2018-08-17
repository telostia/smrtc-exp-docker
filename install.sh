#Create 2 docker containers, 1 for solariumcoind non master node, 1 for solariumcoind masternode
#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt -y -o Acquire::ForceIPv4=true update
apt-get -y -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade
apt -y install apt-transport-https ca-certificates curl software-properties-common git
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt -y -o Acquire::ForceIPv4=true update
apt -y install docker-ce
systemctl start docker
systemctl enable docker
docker pull ubuntu

apt -y install fail2ban
systemctl enable fail2ban
systemctl start fail2ban

#build solarium source git
apt install -y software-properties-common && add-apt-repository ppa:bitcoin/bitcoin && apt update && apt upgrade -y && apt install -y build-essential libtool autotools-dev automake pkg-config libssl-dev autoconf && apt install -y pkg-config libgmp3-dev libevent-dev bsdmainutils && apt install -y libevent-dev libboost-all-dev libdb4.8-dev libdb4.8++-dev nano git && apt install -y libminiupnpc-dev libzmq5 libdb-dev libdb++-dev
cd /root

#building docker
cd /root/solarium/src
rm /root/solarium/src/Dockerfile
wget git remote add origin https://raw.githubusercontent.com/telostia/smrtc-exp-docker/master/Dockerfile
docker build -t "smrtc-explorer" .

