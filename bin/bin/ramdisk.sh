#!/bin/bash

# RD=ramdisk

# if [ ! -e "/Volumes/$RD" ];  then
#     diskutil erasevolume HFS+ "$RD" `hdiutil attach -nomount`
# fi

# mkdir -p /Volumes/$RD/private/tmp

ramfs_size_mb=1024
mount_point=~/volatile

ramfs_size_sectors=$((${ramfs_size_mb}*1024*1024/512))
ramdisk_dev=`hdid -nomount ram://${ramfs_size_sectors}`
newfs_hfs -v 'Volatile' ${ramdisk_dev}
mkdir -p ${mount_point}
mount -o noatime -t hfs ${ramdisk_dev} ${mount_point}

echo "remove with:"
echo "umount ${mount_point}"
echo "diskutil eject ${ramdisk_dev}"
