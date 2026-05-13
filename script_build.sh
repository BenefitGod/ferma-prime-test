#!/bin/bash

# Скрипт для автоматической сборки deb-пакета

set -e

echo "=== Ferma Prime Test - Deb Package Builder ==="

# Проверка наличия необходимых инструментов
if ! command -v dpkg-deb &> /dev/null; then
    echo "Error: dpkg-deb not found. Please install dpkg-dev package."
    exit 1
fi

if ! command -v g++ &> /dev/null; then
    echo "Error: g++ not found. Please install build-essential package."
    exit 1
fi

# Очистка предыдущих сборок
echo "Cleaning previous builds..."
make clean 2>/dev/null || true
rm -rf debian/ferma-test/usr
rm -f ferma-test_*.deb

# Сборка deb-пакета
echo "Building deb package..."
make -f Makefile.deb deb

echo "=== Build complete! ==="
echo "Package: $(ls ferma-test_*.deb)"
echo ""
echo "To install: sudo dpkg -i $(ls ferma-test_*.deb)"
echo "To remove:  sudo dpkg --remove ferma-test"