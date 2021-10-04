#!/bin/bash

systemctl enable smbd
systemctl enable avahi-daemon

usermod -a -G cdrom plex

mkdir -p /plex-data/Movies
mkdir -p /plex-data/TV
mkdir -p /plex-data/Music
mkdir -p /plex-data/Photos
mkdir -p /plex-data/Other
mkdir -p /plex-data/Games
chown -R plex:plex /plex-data

(pdbedit --user=plex 2>&1 > /dev/null) \
  || (echo 'piplex'; echo 'piplex') \
  | smbpasswd -s -a plex

(echo 'piplex'; echo 'piplex') | passwd

mkdir -p /opt/arm
mkdir -p /etc/arm
mkdir -p /var/log/arm
mkdir -p /var/lib/arm
mkdir -p /mnt/dev/sr0
cd /opt/arm
git clone https://github.com/automatic-ripping-machine/automatic-ripping-machine.git .
chown plex:plex -R /opt/arm
chown plex:plex /var/log/arm
chown plex:plex /var/lib/arm
chown plex:plex /mnt/dev/sr0
sudo -u plex pip3 install -r requirements.txt
cp /opt/arm/setup/51-automedia.rules /etc/udev/rules.d/
ln -s /opt/arm/arm.yaml /etc/arm/
