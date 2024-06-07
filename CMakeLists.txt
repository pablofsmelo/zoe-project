# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.20.0)

find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})

include_directories(${ZEPHYR_BASE}/include)

project(zoe-project)

include_directories(${CMAKE_SOURCE_DIR}/components/open62541/include)

add_subdirectory(components/open62541)

target_sources(app PRIVATE
    src/main.c
)

target_link_libraries(app PRIVATE open62541)

# Configurar o compilador C++ para o bootloader
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fexceptions -fno-rtti")




