cmake_minimum_required(VERSION 3.17)
project(rrfs_bufr LANGUAGES Fortran)

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


find_package(bufr REQUIRED)
find_package(w3nco REQUIRED)

set(exe_src stnmlist.f)
set(EXENAME "rrfs_stnmlist.x")

set(module_dir "${CMAKE_CURRENT_BINARY_DIR}/include")

add_executable(${EXENAME} ${exe_src})
target_include_directories(${EXENAME} PRIVATE
        ${CMAKE_CURRENT_BINARY_DIR}/include)

target_link_libraries(${EXENAME} 
	    w3nco::w3nco_4
	    bufr::bufr_4)

install(TARGETS ${EXENAME} RUNTIME DESTINATION ${exec_dir})
