#!/bin/bash -e
# This script backs up the synthesized disk stored within internal system
# disk's APFS partition to a disk image file which can be used as a system
# backup.  The disk image can be restored using the reimage.sh script.

if [ $# -lt 1 ]; then
  echo "USAGE: $0 <disk image file>"
  exit 1
fi

TARGET=$1
SOURCE="$(diskutil list internal virtual | awk '/synthesized/{ print $1; }')"

echo ========================================================================
echo Source is $SOURCE
echo Target is $TARGET
echo ========================================================================
if [ -f $TARGET ]; then
  read -p "Replace existing $TARGET (y/N)? " replace
  if [ "$replace" != 'y' ]; then
    echo "Image creation cancelled."
    exit
  fi
  rm $TARGET
fi

echo ========================================================================
echo Unmounting all volumes within $SOURCE
echo ========================================================================
echo "(diskutil unmountDisk $SOURCE)"
diskutil unmountDisk $SOURCE

echo ========================================================================
echo Creating $TARGET from $SOURCE
echo ========================================================================
echo "(hdiutil create -srcdevice $SOURCE $TARGET)"
hdiutil create -srcdevice $SOURCE $TARGET

echo ========================================================================
echo Verifying $TARGET
echo ========================================================================
echo "(hdiutil verify $TARGET)"
hdiutil verify $TARGET
