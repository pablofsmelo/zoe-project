#!/bin/bash

# Create the libs directory if it doesn't exist
mkdir -p libs
cd libs || exit 1

# Clone the open62541 repository
echo "Cloning open62541..."
git clone https://github.com/open62541/open62541.git || {
  echo "Failed to clone open62541."
  exit 1
}

# Enter the open62541 directory
cd open62541 || exit 1

# Update submodules
echo "Updating submodules..."
git submodule update --init --recursive || {
  echo "Failed to update submodules."
  exit 1
}

# Create the build directory and compile
mkdir -p build
cd build || exit 1

echo "Configuring CMake..."
cmake .. || {
  echo "Failed to configure CMake."
  exit 1
}

echo "Compiling open62541..."
make -j$(nproc) || {
  echo "Failed to compile open62541."
  exit 1
}

echo "Installation complete! open62541 is located in libs/open62541"
