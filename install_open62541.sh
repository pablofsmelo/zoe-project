#!/bin/bash

# Criar diretório libs se não existir
mkdir -p libs
cd libs || exit 1

# Clonar o repositório open62541
echo "Clonando open62541..."
git clone https://github.com/open62541/open62541.git || {
  echo "Erro ao clonar open62541."
  exit 1
}

# Entrar no diretório do open62541
cd open62541 || exit 1

# Atualizar submódulos
echo "Atualizando submódulos..."
git submodule update --init --recursive || {
  echo "Erro ao atualizar submódulos."
  exit 1
}

# Criar diretório de build e compilar
mkdir -p build
cd build || exit 1

echo "Configurando CMake..."
cmake .. || {
  echo "Erro ao configurar o CMake."
  exit 1
}

echo "Compilando open62541..."
make -j$(nproc) || {
  echo "Erro ao compilar open62541."
  exit 1
}

echo "Instalação concluída! open62541 está em libs/open62541"