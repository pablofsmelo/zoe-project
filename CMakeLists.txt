cmake_minimum_required(VERSION 3.20.0)

project(server)

set(Python3_EXECUTABLE "/usr/bin/python3" CACHE STRING "" FORCE)
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})

# Xtensa only: linker relaxation for call8 (not used on RISC-V e.g. ESP32-C3)
if(CMAKE_C_COMPILER MATCHES "xtensa-")
  zephyr_ld_options(-Wl,--relax -Wl,-mlongcalls)
  add_compile_options(-mlongcalls)
endif()

# Use amalgamated open62541 (single .c file for better linking)
target_sources(app PRIVATE src/main.c src/open62541.c)
target_include_directories(app PRIVATE src)
target_compile_definitions(app PRIVATE UA_MINIMAL_CONFIG)
# RISC-V (e.g. ESP32-C3): provide atomic builtins via Zephyr API (no libatomic in SDK)
if(CMAKE_C_COMPILER MATCHES "riscv")
  target_sources(app PRIVATE src/atomic_stub_riscv.c)
endif()

# Optimize for code size
add_compile_options(-Os -fno-asynchronous-unwind-tables -fno-unwind-tables -ffunction-sections -fdata-sections)
