#!/bin/bash
#
# To call this script, make sure make_ext4fs is somewhere in PATH

function usage() {
cat<<EOT
Usage:
mkuserimg.sh [-sJzw] SRC_DIR OUTPUT_FILE EXT_VARIANT MOUNT_POINT SIZE
EOT
}

echo "in mkuserimg.sh PATH=$PATH"

ARGUMENTS=
if [[ "$1" == *s* ]]; then
  ARGUMENTS="${ARGUMENTS}s"
fi
if [[ "$1" == *J* ]]; then
  ARGUMENTS="${ARGUMENTS}J"
fi
if [[ "$1" == *z* ]]; then
  ARGUMENTS="${ARGUMENTS}z"
fi
if [[ "$1" == *w* ]]; then
  ARGUMENTS="${ARGUMENTS}w"
fi
if [[ "$1" == *s* ]] || [[ "$1" == *J* ]] || [[ "$1" == *z* ]] || [[ "$1" == *w* ]]; then
  shift
fi
if [ $# -ne 4 -a $# -ne 5 ]; then
  usage
  exit 1
fi

SRC_DIR=$1
if [ ! -d $SRC_DIR ]; then
  echo "Can not find directory $SRC_DIR!"
  exit 2
fi

OUTPUT_FILE=$2
EXT_VARIANT=$3
MOUNT_POINT=$4
SIZE=$5

case $EXT_VARIANT in
  ext4) ;;
  *) echo "Only ext4 is supported!"; exit 3 ;;
esac

if [ -z $MOUNT_POINT ]; then
  echo "Mount point is required"
  exit 2
fi

if [ -z $SIZE ]; then
    SIZE=128M
fi

MAKE_EXT4FS_CMD="make_ext4fs -$ARGUMENTS -l $SIZE -a $MOUNT_POINT $OUTPUT_FILE $SRC_DIR"
echo $MAKE_EXT4FS_CMD
$MAKE_EXT4FS_CMD
if [ $? -ne 0 ]; then
  exit 4
fi
