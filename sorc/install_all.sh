#!/bin/sh
set -eux
#------------------------------------
# USER DEFINED STUFF:
#
# USE_PREINST_LIBS: set to "true" to use preinstalled libraries.
#                   Anything other than "true"  will use libraries locally.
#------------------------------------

export USE_PREINST_LIBS="true"

#------------------------------------
# END USER DEFINED STUFF
#------------------------------------

export build_dir=`pwd`
logs_dir=$build_dir/logs
if [ ! -d $logs_dir  ]; then
  echo "Creating logs folder"
  mkdir $logs_dir
fi

EXEdir=../../../exec
ALTexedir=../../../bin

# Check final exec folder exists
if [ ! -d $EXEdir ]; then

if [ -d $ALTexedir ]; then
echo "using $ALTexedir"
EXEdir=$ALTexedir
else
  echo "Creating $EXEdir folder"
  mkdir -p $EXEdir
fi

fi

#------------------------------------
# INCLUDE PARTIAL BUILD 
#------------------------------------

. ./partial_build.sh

#------------------------------------
# install bufr
#------------------------------------
$Build_bufr && {
echo " .... Installing bufr .... "
cp ./rrfs_bufr.fd/rrfs_bufr.x $EXEdir/rrfs_bufr
}

#------------------------------------
# build sndp
#------------------------------------
$Build_sndp && {
echo " .... Installing sndp .... "
cp ./rrfs_sndp.fd/rrfs_sndp.x $EXEdir/rrfs_sndp
}

#------------------------------------
# build stnmlist
#------------------------------------
$Build_stnmlist && {
echo " .... Install stnmlist .... "
cp ./rrfs_stnmlist.fd/rrfs_stnmlist.x $EXEdir/rrfs_stnmlist
}

echo;echo " .... Install system finished .... "

exit 0
