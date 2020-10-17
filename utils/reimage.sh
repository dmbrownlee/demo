#!/bin/bash
# This script is used to restore an APFS system disk that has been backed up
# to a disk image file.  It assumes your current internal, physical disk has
# a single APFS container partition and overwrites that.

if [ $# -lt 1 ]; then
  echo "USAGE: $0 <disk image file>"
  exit 1
fi

DMG=$1
echo ========================================================================
echo Attaching disk image $DMG
echo ========================================================================
echo "(hdiutil attach $DMG)"
hdiutil attach "$DMG"

TARGET="/dev/$(diskutil list internal physical | awk '/Apple_APFS/{ print $NF; }')"
SOURCE="$(diskutil list external virtual | awk '/synthesized/{ print $1; }')"

if [ "$TARGET" == "/dev/" ]; then
  echo "Failed to find an APFS container on the internal, physical disk."
  exit 1
fi

echo ========================================================================
echo Source is $SOURCE
echo Target is $TARGET
echo ========================================================================

# Deleting the APFS container unmounts the APFS volumes first, then creates
# an HFS+ partition named "Untitled" which it mounts.  It has to be unmounted
# before using restoring to it with asr.
echo ========================================================================
echo Replacing APFS Container on $TARGET with HFS+ filesystem
echo ========================================================================
echo "(diskutil apfs deleteContainer $TARGET)"
diskutil apfs deleteContainer $TARGET
echo ========================================================================
echo Unmounting $TARGET before restoring
echo ========================================================================
echo "(umount $TARGET)"
umount $TARGET
echo ========================================================================
echo "Restoring APFS Container ($SOURCE) inside $DMG to $TARGET"
echo ========================================================================
echo "(asr --source $SOURCE --target $TARGET --erase --useInverter)"
asr --source $SOURCE --target $TARGET --erase --useInverter
