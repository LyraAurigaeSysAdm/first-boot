#!/bin/bash

# On installe le docker certbot
echo ""
echo "**********************************"
echo "* Installation du docker Certbot *"
echo "**********************************"
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
mkdir -p /var/lib/letsencrypt
chmod +x /opt/renew_ssl_certificate.sh
echo ""
echo "*************************************"
echo "* Fichiers du dossier racine copiés *"
echo "*************************************"
echo ""

# On ajoute la cron de renouvellement du certificat SSL (tente un renouvellement tous les lundis)
if (( $(crontab -l | grep "/opt/renew_ssl_certificate.sh" | wc -l) > 0 ))
then
# La ligne existe déjà, on l'indique
echo ""
echo "**********************************************************"
echo "* Ligne de cron 'renew_ssl_certificate.sh' déjà présente *"
echo "**********************************************************"
echo ""
else
# elle n'existe pas encore, on l'ajoute
(crontab -l ; echo "0 1 * * 1 /opt/renew_ssl_certificate.sh > /dev/null") | crontab
echo ""
echo "****************************************************"
echo "* Ligne de cron 'renew_ssl_certificate.sh' ajoutée *"
echo "****************************************************"
echo ""
fi

# On demande à modifier le fichier de configuration pour les token
echo ""
echo "**********************************************************************************"
echo "* Veuillez modifier le fichier qui va s'ouvrir, puis l'enregistrer et le fermer. *"
echo "*            Les tokens sont à générer et récupérer sur le compte OVH            *"
echo "*            Pour enregistrer, faites [CTRL-O], [ENTREE] puis [CTRL-X]           *"
echo "**********************************************************************************"
echo ""
sleep 10s
nano /etc/letsencrypt/ovhapi
chmod 600 /etc/letsencrypt/ovhapi
echo ""
echo "********************************************************************************"
echo "* Fichier modifié, vous pouvez le re-modifier à tout moment avec la commande : *"
echo "*                         nano /etc/letsencrypt/ovhapi                         *"
echo "********************************************************************************"
echo ""

# On lance la première génération du certificat (télécharge l'image docker au passage)
/opt/renew_ssl_certificate.sh

echo ""
echo "******************************************************************"
echo "* Veuillez vérifier que le certificat a bien été généré          *"
echo "* Note : Ignorez l'erreur 'reverseproxy introuvable' si présente *"
echo "******************************************************************"
echo ""

# Fin du script
echo ""
echo "***************************"
echo "* Docker Certbot installé *"
echo "***************************"
echo ""