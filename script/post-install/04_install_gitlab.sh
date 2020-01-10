#!/bin/bash

# On installe le docker GitLab
echo ""
echo "*********************************"
echo "* Installation du docker GitLab *"
echo "*********************************"
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
mkdir -p /opt/docker_gitlab/data /var/log/gitlab /etc/gitlab /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/git.lyra-aurigae.space /etc/nginx/sites-enabled/git.lyra-aurigae.space
echo ""
echo "*************************************"
echo "* Fichiers du dossier racine copiés *"
echo "*************************************"
echo ""

# On lance le docker compose de GitLab
docker network create -d bridge --subnet 172.10.0.0/24 reverseproxy-main-network
cd /opt/docker_gitlab && docker-compose up -d
echo ""
echo "**************************************************************"
echo "* Docker Gitlab installé (vérifiez les erreurs potentielles) *"
echo "**************************************************************"
echo ""