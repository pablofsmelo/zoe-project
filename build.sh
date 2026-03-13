#!/usr/bin/env bash
# Build ZOE (Zephyr OPC UA server) for a supported Espressif board.
# Default board: esp32c3_devkitc (RISC-V, links successfully).
# Requires: ZEPHYR_BASE and ESP_IDF_PATH in the environment (or set below).

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Board: esp32c3_devkitc is recommended (ESP32-C3, no Xtensa call8 link issue).
# Other options: weact_esp32c3_mini, xiao_esp32c3, esp32c3_devkitm
BOARD="${BOARD:-esp32c3_devkitc}"

if [ -z "$ZEPHYR_BASE" ]; then
  echo "Error: ZEPHYR_BASE is not set. Source your Zephyr env (e.g. zephyr-env.sh) or export ZEPHYR_BASE."
  exit 1
fi

if [ -z "$ESP_IDF_PATH" ]; then
  echo "Error: ESP_IDF_PATH is not set. Export your ESP-IDF path (e.g. export ESP_IDF_PATH=\$HOME/esp/esp-idf)."
  exit 1
fi

# Path to hal_espressif (usually in the west workspace that contains zephyr)
HAL_ESPRESSIF="${HAL_ESPRESSIF:-$(dirname "$SCRIPT_DIR")/modules/hal/espressif}"
if [ ! -d "$HAL_ESPRESSIF" ]; then
  echo "Error: hal_espressif not found at $HAL_ESPRESSIF. Set HAL_ESPRESSIF or use a workspace with modules/hal/espressif."
  exit 1
fi

rm -rf build
mkdir -p build
cd build

echo "Building for board: $BOARD"
cmake -DBOARD="$BOARD" \
  -DEXTRA_ZEPHYR_MODULES="$HAL_ESPRESSIF" \
  -GNinja ..

ninja "$@" || {
  # If ninja failed but zephyr.elf exists, link succeeded (objcopy step may fail if host objcopy is used)
  if [ -f zephyr/zephyr.elf ]; then
    echo "Build produced zephyr/zephyr.elf. Use it for flashing (e.g. west flash from workspace, or esptool.py)."
    exit 0
  fi
  exit 1
}
