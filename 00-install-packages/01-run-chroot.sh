#!/bin/bash -e


curl --cacert /etc/ssl/certs/ca-certificates.crt https://downloads.plex.tv/plex-keys/PlexSign.key | apt-key add -
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
apt-get update

# force-confold to work around an issue where I need to install the repo info but the 
# package also wants to install it on first install
apt-get -o Dpkg::Options::="--force-confold" -y install plexmediaserver
