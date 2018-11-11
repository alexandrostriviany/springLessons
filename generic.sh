#!/bin/sh

unset LD_LIBRARY_PATH
unset LD_PRELOAD

echo "Info: Checking for prerequisites and creating folders..."

if [ -d /tmp/mnt/media/_system ]
then
    echo "Warning: Folder /tmp/mnt/media/_system exists!"
else
    mkdir /tmp/mnt/media/_system
fi
# no need to create many folders. entware-tmp/mnt/sda6 package creates most
for folder in bin etc lib/opkg tmp var/lock
do
  if [ -d "/tmp/mnt/media/_system/$folder" ]
  then
    echo "Warning: Folder /tmp/mnt/media/_system/$folder exists!"
    echo "Warning: If something goes wrong please clean /tmp/mnt/media/_system folder and try again."
  else
    mkdir -p /tmp/mnt/media/_system/$folder
  fi
done

echo "Info: Opkg package manager deployment..."
DLOADER="ld-linux.so.3"
URL=http://bin.entware.net/armv7sf-k2.6/installer
wget $URL/opkg -O /tmp/mnt/media/_system/bin/opkg
chmod 755 /tmp/mnt/media/_system/bin/opkg
wget $URL/opkg.conf -O /tmp/mnt/media/_system/etc/opkg.conf
wget $URL/ld-2.23.so -O /tmp/mnt/media/_system/lib/ld-2.23.so
wget $URL/libc-2.23.so -O /tmp/mnt/media/_system/lib/libc-2.23.so
wget $URL/libgcc_s.so.1 -O /tmp/mnt/media/_system/lib/libgcc_s.so.1
wget $URL/libpthread-2.23.so -O /tmp/mnt/media/_system/lib/libpthread-2.23.so
cd /tmp/mnt/media/_system/lib
chmod 755 ld-2.23.so
ln -s ld-2.23.so $DLOADER
ln -s libc-2.23.so libc.so.6
ln -s libpthread-2.23.so libpthread.so.0

echo "Info: Basic packages installation..."
/tmp/mnt/media/_system/bin/opkg update
/tmp/mnt/media/_system/bin/opkg install entware-tmp/mnt/sda6

# Fix for multiuser environment
chmod 777 /tmp/mnt/media/_system/tmp

# now try create symlinks - it is a std installation
if [ -f /etc/passwd ]
then
    ln -sf /etc/passwd /tmp/mnt/media/_system/etc/passwd
else
    cp /tmp/mnt/media/_system/etc/passwd.1 /tmp/mnt/media/_system/etc/passwd
fi

if [ -f /etc/group ]
then
    ln -sf /etc/group /tmp/mnt/media/_system/etc/group
else
    cp /tmp/mnt/media/_system/etc/group.1 /tmp/mnt/media/_system/etc/group
fi

if [ -f /etc/shells ]
then
    ln -sf /etc/shells /tmp/mnt/media/_system/etc/shells
else
    cp /tmp/mnt/media/_system/etc/shells.1 /tmp/mnt/media/_system/etc/shells
fi

if [ -f /etc/shadow ]
then
    ln -sf /etc/shadow /tmp/mnt/media/_system/etc/shadow
fi

if [ -f /etc/gshadow ]
then
    ln -sf /etc/gshadow /tmp/mnt/media/_system/etc/gshadow
fi

if [ -f /etc/localtime ]
then
    ln -sf /etc/localtime /tmp/mnt/media/_system/etc/localtime
fi

echo "Info: Congratulations!"
echo "Info: If there are no errors above then Entware was successfully initialized."
echo "Info: Add /tmp/mnt/media/_system/bin & /tmp/mnt/media/_system/sbin to your PATH variable"
echo "Info: Add '/tmp/mnt/media/_system/etc/init.d/rc.unslung start' to startup script for Entware services to start"
echo "Info: Found a Bug? Please report at https://github.com/Entware/Entware/issues"
