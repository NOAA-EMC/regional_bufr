#! /bin/bash

prefix="../install"
compiler="intel"
verbose_opt=""

cmake_opts=" -DCMAKE_INSTALL_PREFIX=$prefix -Wno-dev"


source ./versions/build.ver
module use -a ./modulefiles/
module load build_v8.0.0-cray-intel

# module list

rm -rf build install
mkdir build && cd build

echo execute cmake with cmake_opts $cmake_opts

cmake $cmake_opts ../

echo past cmake
