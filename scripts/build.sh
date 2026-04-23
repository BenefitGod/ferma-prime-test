#!/bin/bash
# Скрипт сборки

set -e

echo "=== Building Ferma Prime Test ==="
echo "Compiler: $(g++ --version | head -n1)"
echo "Date: $(date)"

# Clean previous build
make clean

# Build the program
make all

echo "Build completed successfully!"
ls -la ferma-test*