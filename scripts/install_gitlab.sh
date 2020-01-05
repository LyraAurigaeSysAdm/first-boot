#!/bin/bash

# On installe Docker
apt update
apt upgrade
apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common rsync
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update
apt install docker-ce docker-ce-cli containerd.io
echo ""
echo "*******************"
echo "* Docker installé *"
echo "*******************"
echo ""

# On installe Docker-compose
if (( $(ls /usr/local/bin | grep docker-compose | wc -l) > 0 ))
then
echo ""
echo "********************************"
echo "* Docker-compose déjà installé *"
echo "********************************"
echo ""
else
curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
echo ""
echo "***************************"
echo "* Docker-compose installé *"
echo "***************************"
echo ""
fi

# On copie les fichiers nécessaires
rsync -r ../root/* /
mkdir -p /opt/docker_gitlab/data /var/log/gitlab /etc/gitlab
echo ""
echo "*************************************"
echo "* Fichiers du dossier racine copiés *"
echo "*************************************"
echo ""

# On lance le docker compose de GitLab
cd /opt/docker_gitlab && docker-compose up -d
echo ""
echo "***********************************************************"
echo "* Docker Gitlab lancé (vérifiez les erreurs potentielles) *"
echo "***********************************************************"
echo ""