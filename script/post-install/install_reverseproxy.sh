#!/bin/bash

# On installe le docker NginX
echo ""
echo "*********************************"
echo "* Installation du reverse proxy *"
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
mkdir -p /etc/letsencrypt
echo ""
echo "*************************************"
echo "* Fichiers du dossier racine copiés *"
echo "*************************************"
echo ""

# On lance le docker compose de GitLab
cd /opt/docker_reverseproxy && docker-compose up -d
echo ""
echo "**************************************************************"
echo "* Reverse proxy installé (vérifiez les erreurs potentielles) *"
echo "**************************************************************"
echo ""