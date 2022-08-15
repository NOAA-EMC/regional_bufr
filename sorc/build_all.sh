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

EXEdir=../../exec/fv3

# Check final exec folder exists
if [ ! -d $EXEdir ]; then
  echo "Creating $EXEdir folder"
  mkdir -p $EXEdir
fi

#------------------------------------
# INCLUDE PARTIAL BUILD 
#------------------------------------

. ./partial_build.sh


#------------------------------------
# build bufr
#------------------------------------
$Build_bufr && {
echo " .... Building bufr .... "
./build_bufr.sh > $logs_dir/build_bufr.log 2>&1
}

#------------------------------------
# build sndp
#------------------------------------
$Build_sndp && {
echo " .... Building sndp .... "
./build_sndp.sh > $logs_dir/build_sndp.log 2>&1
}

#------------------------------------
# build stnmlist
#------------------------------------
$Build_stnmlist && {
echo " .... Building stnmlist .... "
./build_stnmlist.sh > $logs_dir/build_stnmlist.log 2>&1
}

echo;echo " .... Build system finished .... "

exit 0
