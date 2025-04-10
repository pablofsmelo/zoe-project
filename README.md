# ZOE Project

> Zephyr-based OPC UA Server running on ESP32 using open62541

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 🧠 About the Project

**ZOE (Zephyr OPC UA ESP32)** is an open-source initiative that demonstrates how to run an **OPC UA server** on **ESP32** using the [**open62541**](https://github.com/open62541/open62541) stack and **Zephyr RTOS**.

The project provides a working reference for implementing **industrial-grade communication protocols** in embedded devices. It is ideal for developers working with IoT, IIoT, automation systems, and standardized data exchange over OPC UA.

---

## 📦 Zephyr Installation (Required)

Before building the ZOE Project, you need to install and configure **Zephyr RTOS** with ESP32 support.

Follow the official Zephyr documentation for ESP32 setup:
👉 [https://docs.zephyrproject.org/latest/boards/xtensa/esp32/doc/index.html](https://docs.zephyrproject.org/latest/boards/xtensa/esp32/doc/index.html)

Make sure to:
- Install the **Zephyr SDK**
- Install **West** (Zephyr's meta-tool)
- Initialize and update Zephyr's repositories
- Export the environment with `zephyr-env.sh` or equivalent

Once Zephyr is working correctly with ESP32, proceed with the steps below.

---

## 🚀 Getting Started

### ✅ Prerequisites

- Zephyr SDK and West installed and configured for ESP32
- ESP-IDF setup (if needed for low-level ESP32 features)
- Git with submodule support
- Python 3, CMake, Ninja build system
- Supported board (e.g., `esp32s3_devkitc`)

### 🔧 Setup Instructions

```bash
# Clone the repository with submodules
git clone --recurse-submodules https://github.com/your-username/zoe-project.git
cd zoe-project

# Run the install script to set up open62541
./install_open62541.sh

# Build the project for your ESP32 board
west build -b esp32 -- -DDTC_OVERLAY_FILE=boards/esp32.overlay

# Flash the binary to the ESP32 board
west flash
