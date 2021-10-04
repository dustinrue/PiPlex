# PiPlex Image Builder

This repo contains routines to extend the base pi-gen system to build a custom Raspberry Pi OS image that contains [Plex Media Server](https://www.plex.tv), [Automatic Ripping Machine](https://github.com/automatic-ripping-machine/automatic-ripping-machine) and Samba. The resulting image is focused on creating a small appliance that allows for easy management and serving of your music collection.

You can either build the image yourself or simply download a prebuilt image from the releases page.

## Using

Simply download the latest image from the release page and copy it to an SD card in the usual way (detailed information is available at [https://www.raspberrypi.org/documentation/computers/getting-started.html#installing-the-operating-system](https://www.raspberrypi.org/documentation/computers/getting-started.html#installing-the-operating-system)). 

Once the image is copied to an SD card put it into your Raspberry Pi 3b+ or better and connect it to power and ethernet (WiFi works too if you pre-configured it using the headless configuration option). After some time the Pi will be online and ready to use. 

### SSH Access

Unlike a normal Raspberry Pi OS system, SSH is enabled by default. You can access the console of your Pi using an ssh client. Connect as `pi` to `piplex.local` and login with `piplex`. You can now manage your system just like you normally would. This currently the only method modifying the configuration of most services.

### Adding External Storage

You may not want to use the internal storage of the Pi to host your music. Before configuring Plex Media Server, I recommend attaching external storage using a USB drive or by attaching to some other file store like a NAS. 

If you add external storage you must ensure that the `plex` on the Pi is allowed to write to the target storage device. The easiest option is to create a directory and own it as the userid for `plex` which is 

### Attaching a cdrom

If an external cdrom is attached to the Pi you will be able to utlize Automatic Ripping Machine to rip CDs. If you plan to use ARM you must update the configuration file located at /usr/lib/plexmediaserver/.abcde.conf and update the `OUTPUTDIR` variable to the path of your Music dir.

You will also need to create a `flac` directory in the Music directory so abcde can output the resulting files. Be sure to own the directory as `plex`.

### Configuring Plex Media Server

Visit [http://piplex.local:32400/web](http://piplex.local:32400/web) to configure Plex Media Server. Sign into your account and then create a new library for Music. You can browse to the pre-existing directory at /plex-data or use any externally mounted directory you created.

### Configuring Samba

Samba comes preinstalled to look at the /plex-data directory. If you have added external storage be sure to modify `/etc/samba/smb.conf` so you can still access your data that way.

The default username/password for accessing Samba is plex/piplex

## Building

To use this project you must first install pi-gen, available at [https://github.com/RPi-Distro/pi-gen](https://github.com/RPi-Distro/pi-gen). Start by setting up pi-gen as described and ensure you are able to successfully build the base image. Once complete, clone this repository into where you cloned the pi-gen repository as "stage-piplex1" (`git clone https://github.com/dustinrue/PiPlex.git stage-piplex1`). Then, create a config file with the following in it:

```
IMG_NAME=PiPlex
DEPLOY_ZIP=0
TARGET_HOSTNAME=piplex
KEYBOARD_KEYMAP=us
KEYBOARD_LAYOUT="English (US)"
FIRST_USER_PASS=piplex
ENABLE_SSH=1
STAGE_LIST="stage0 stage1 stage2 stage-piplex1"
```

You can modify any option you want but you must include stage-piplex1 as a step, probably the last one.

