#!/bin/bash

if [ "$(whoami)" != 'root' ]; then
        echo "Must be root to run $0."
        exit 1;
fi

if [ "$(cat /etc/mtab|grep /dev/mapper/crypt)" == '/dev/mapper/crypt /mnt/crypt ext4 rw,relatime,data=ordered 0 0' ]; then
        echo "/mnt/crypt allready mounted."
        echo "If it should't be...check it."
        exit 1;
fi

if [ "$(cryptsetup status crypt|grep crypt)" == '/dev/mapper/crypt is active and is in use.' ]; then
        echo "/mnt/crypt allready active"
        echo "Mounting on /mnt/crypt"
        mount /dev/mapper/crypt /mnt/crypt
        echo "Done."
        exit 1;
fi

echo "Decrypting /dev/sda1"

cryptsetup open /dev/sda1 crypt

echo "Mounting on /mnt/crypt"

mount /dev/mapper/crypt /mnt/crypt

echo "Done."

exit;
