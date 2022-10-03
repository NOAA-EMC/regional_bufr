#! /bin/sh


module purge >& /dev/null

# module load ncep
# module load craype-sandybridge
# module use -a /opt/cray/modulefiles

# source /apps/prod/lmodules/startLmod


source ../versions/build.ver

module use -a ../modulefiles/
module load build_v8.0.0-cray-intel

module list

cd ./rrfs_stnmlist.fd

make clean
make 

make clean

cd ../
