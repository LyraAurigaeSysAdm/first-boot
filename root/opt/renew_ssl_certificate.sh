#!/bin/sh

# On génère le certificat en utilisant le module certbot "DNS-OVH"
docker run -it --rm --name certbot \
           -v "/etc/letsencrypt:/etc/letsencrypt" \
           -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
           certbot/dns-ovh:latest certonly --dns-ovh \
           --dns-ovh-credentials /etc/letsencrypt/ovhapi \
           --non-interactive --agree-tos \
           --email webmaster@lyra-aurigae.space \
           --dns-ovh-propagation-seconds 60 \
           -d 'lyra-aurigae.space' \
           -d '*.lyra-aurigae.space'

# On relance nginx (nom de l'instance : 'reverseproxy') pour prendre en compte le nouveau certificat
docker container exec reverseproxy nginx -s reload