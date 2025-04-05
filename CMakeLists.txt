# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.20.0)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -pthread")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")

find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})

include_directories(${ZEPHYR_BASE}/include)

project(zoe-project)

# Add open62541 include directory
include_directories(${CMAKE_SOURCE_DIR}/libs/open62541/include)
include_directories(${CMAKE_SOURCE_DIR}/libs/open62541/build/src_generated)

# Add open62541 as a subdirectory
add_subdirectory(libs/open62541)

target_sources(app PRIVATE
    src/main.c
)

# Specify the library path
set(OPEN62541_LIB_DIR ${CMAKE_SOURCE_DIR}/libs/open62541/build/bin)

# Link the open62541 library
target_link_libraries(app PRIVATE "${OPEN62541_LIB_DIR}/libopen62541.a")

# Configure C++ compiler for bootloader (if needed)
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fexceptions -fno-rtti")