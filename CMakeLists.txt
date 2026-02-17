cmake_minimum_required(VERSION 3.20.0)

project(server)

set(Python3_EXECUTABLE "/usr/bin/python3" CACHE STRING "" FORCE)
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})

# Use amalgamated open62541 (single .c file for better linking)
target_sources(app PRIVATE src/main.c src/open62541.c)
target_include_directories(app PRIVATE src)

# Optimize for code size to fit in ESP32
add_compile_options(-Os -fno-asynchronous-unwind-tables -fno-unwind-tables -ffunction-sections -fdata-sections)

# Linker relaxation and garbage collection for Xtensa call8 relocations
target_link_options(app PRIVATE LINKER:--relax LINKER:--gc-sections)
