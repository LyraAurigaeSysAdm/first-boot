#!/usr/bin/env bash

apt-get update
apt-get install -y  \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common