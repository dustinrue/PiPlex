#!/bin/bash

mkdir "${ROOTFS_DIR}/etc/arm"

install -m 644 files/smb.conf         "${ROOTFS_DIR}/etc/samba/smb.conf"
install -m 644 files/smb.service      "${ROOTFS_DIR}/etc/avahi/services/smb.service"
install -m 644 files/abcde.conf       "${ROOTFS_DIR}/var/lib/plexmediaserver/.abcde.conf"
install -m 755 files/apply_updates.sh "${ROOTFS_DIR}/etc/cron.weekly"

echo "/dev/sr0  /mnt/dev/sr0  udf,iso9660  users,noauto,exec,utf8  0  0" >> "${ROOTFS_DIR}/etc/fstab"
