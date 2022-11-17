cmake_minimum_required(VERSION 3.17)
# project(rrfs_bufr LANGUAGES Fortran)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/../cmake")

message(WARNING "do we have CMAKE_MODULE_PATH = ${CMAKE_MODULE_PATH}")


if(CMAKE_Fortran_COMPILER_ID MATCHES "^(Intel)$")
  set(CMAKE_Fortran_FLAGS
  "-g -traceback -fp-model precise -convert big_endian -assume noold_ldout_format")
   set(CMAKE_Fortran_FLAGS_RELEASE "-O2")
   set(CMAKE_Fortran_FLAGS_DEBUG "-O0")
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^(GNU|Clang|AppleClang)$")
   set(CMAKE_Fortran_FLAGS
   "-g -fbacktrace -ffree-form -ffree-line-length-none -fconvert=big-endian")
   set(CMAKE_Fortran_FLAGS_RELEASE "-O3")
   set(CMAKE_Fortran_FLAGS_DEBUG "-O0 -ggdb -fno-unsafe-math-optimizations -frounding-math -fsignaling-nans -ffpe-trap=invalid,zero,overflow -fbounds-check")
  if(CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 10)
     set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -fallow-argument-mismatch")
  endif()
endif()

set(lib_src
VRBLS2D_mod.f
VRBLS3D_mod.f
MASKS_mod.f
SOIL_mod.f
WRFBUFR.f
PROF_FV3SAR_NET.f
iw3jdn.f 
w3fs26.f 
w3movdat.f 
PARA_RANGE.f90
w3reddat.f)

add_library(my_lib ${lib_src})


find_package(w3nco REQUIRED)
find_package(bufr REQUIRED)
find_package(NetCDF REQUIRED COMPONENTS Fortran)


set(exe_src WRFBUFR.f ${lib_src})
set(EXENAME "rrfs_bufr.x")

set(module_dir "${CMAKE_CURRENT_BINARY_DIR}/include")

add_executable(${EXENAME} ${exe_src})
target_include_directories(${EXENAME} PRIVATE
        ${CMAKE_CURRENT_BINARY_DIR}/include)

target_link_libraries(${EXENAME} my_lib
	    w3nco::w3nco_4
	    bufr::bufr_4
	    NetCDF::NetCDF_Fortran)

install(TARGETS ${EXENAME} RUNTIME DESTINATION ${exec_dir})
