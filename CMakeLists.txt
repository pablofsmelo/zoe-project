# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.20.0)

#set(DTC_OVERLAY_FILE ${CMAKE_SOURCE_DIR}/boards/esp32.overlay)

find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(zoe-project)

target_sources(app PRIVATE src/main.c)
