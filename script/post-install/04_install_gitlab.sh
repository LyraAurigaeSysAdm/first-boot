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
mkdir -p /docker/data/gitlab /docker/log/gitlab /docker/conf.d/gitlab /docker/conf.d/reverseproxy/sites-available /docker/conf.d/reverseproxy/sites-enabled /docker/source/compose/gitlab/
cp ../root/etc/nginx/reverseproxy_main/sites-available/git.lyra-aurigae.space /docker/conf.d/reverseproxy/sites-available/git.lyra-aurigae.space
cd /docker/conf.d/reverseproxy/sites-enabled && ln -s ../sites-available/git.lyra-aurigae.space gitlab
cp ../root/opt/docker_gitlab/docker-compose.yml /docker/source/compose/gitlab/docker-compose.yml
echo ""
echo "*************************************"
echo "* Fichiers du dossier racine copiés *"
echo "*************************************"
echo ""

# On lance le docker compose de GitLab
docker network create -d bridge --subnet 172.10.0.0/24 reverseproxy-main-network
cd /docker/source/compose/gitlab && docker-compose up -d
echo ""
echo "**************************************************************"
echo "* Docker Gitlab installé (vérifiez les erreurs potentielles) *"
echo "**************************************************************"
echo ""