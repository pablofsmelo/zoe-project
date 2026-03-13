# ZOE Project

> Zephyr-based OPC UA server on Espressif (ESP32-C3 recommended) using open62541

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## About the Project

**ZOE (Zephyr OPC UA Espressif)** is an open-source project that runs an **OPC UA server** on **Espressif** boards using the [**open62541**](https://github.com/open62541/open62541) stack and **Zephyr RTOS**.

Supported target: **ESP32-C3** (RISC-V). The classic ESP32 (Xtensa) is not supported for this application due to linker range limitations; see `LIMITATIONS.md` and `docs/OPC_UA_ESPESSIF_MINIMO.md` for details and alternatives.

The project is a reference for **industrial communication (OPC UA)** on embedded devices with Zephyr, suitable for IoT, IIoT, and automation.

---

## Zephyr Setup (Required)

Install and configure **Zephyr RTOS** with Espressif support before building.

- Install the **Zephyr SDK** and **West**.
- Initialize and update the Zephyr workspace and export the environment (e.g. `source zephyr-env.sh`).
- Ensure **ESP-IDF** is installed and its path is set (e.g. `export ESP_IDF_PATH=$HOME/esp/esp-idf`).

For board-specific details, see the [Zephyr Espressif documentation](https://docs.zephyrproject.org/latest/boards/riscv/esp32c3_devkitc/doc/index.html).

---

## Getting Started

### Prerequisites

- Zephyr SDK and West installed and configured
- **ESP-IDF** (path set in `ESP_IDF_PATH`)
- **ZEPHYR_BASE** set (e.g. after sourcing `zephyr-env.sh`)
- Hal Espressif module (e.g. `modules/hal/espressif` in the workspace containing Zephyr)
- Python 3, CMake, Ninja
- Supported board: **esp32c3_devkitc** (default); others such as `weact_esp32c3_mini`, `xiao_esp32c3`, `esp32c3_devkitm` can be tried

### Setup

```bash
# Clone with submodules
git clone --recurse-submodules https://github.com/your-username/zoe-project.git
cd zoe-project

# Install open62541 (if applicable)
./install_open62541.sh
```

### Build

From the project root, with `ZEPHYR_BASE` and `ESP_IDF_PATH` set:

```bash
./build.sh
```

Default board is **esp32c3_devkitc**. To use another board:

```bash
BOARD=weact_esp32c3_mini ./build.sh
```

Optional: set `HAL_ESPRESSIF` if the hal is not at `../modules/hal/espressif` relative to the project.

### Flash

The build produces **`build/zephyr/zephyr.elf`**. Use it for flashing, for example:

- From the Zephyr workspace: `west flash`
- Or with **esptool**: `esptool.py --chip esp32c3 ...` (see Zephyr/ESP-IDF docs)

If Ninja reports an error only in the final step (e.g. objcopy), the **`.elf`** is still valid and can be used for flashing.

---

## License

MIT — see [LICENSE](LICENSE).
