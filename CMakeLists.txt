# Cmake draft for regional_bufr

cmake_minimum_required(VERSION 3.15)

file(STRINGS "VERSION" pVersion LIMIT_COUNT 1)

project(
  regional_bufr
  VERSION ${pVersion}
  LANGUAGES Fortran)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

message(WARNING "do we have CMAKE_MODULE_PATH = ${CMAKE_MODULE_PATH}")

# Handle user options.
option(BUILD_BUFREXEC "Build rrfs_bufr executable" ON)
option(BUILD_SNDPEXEC "Build rrfs_sndp executable" ON)
option(BUILD_STNMLISTEXEC "Build rrfs_stnmlist executable" ON)

if(NOT CMAKE_BUILD_TYPE MATCHES "^(Debug|Release|RelWithDebInfo|MinSizeRel)$")
  message(STATUS "Setting build type to 'Release' as none was specified.")
  set(CMAKE_BUILD_TYPE
      "Release"
      CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release"
                                                 "MinSizeRel" "RelWithDebInfo")
endif()

if(NOT CMAKE_Fortran_COMPILER_ID MATCHES "^(Intel|GNU|Clang|AppleClang)$")
  message(WARNING "Compiler not officially supported: ${CMAKE_Fortran_COMPILER_ID}")
endif()

find_package(MPI REQUIRED)
find_package(NetCDF REQUIRED COMPONENTS Fortran)

if(BUILD_BUFREXEC)
  find_package(w3nco REQUIRED)
  find_package(NetCDF REQUIRED)
  find_package(bufr REQUIRED)
endif()

add_subdirectory(sorc)
