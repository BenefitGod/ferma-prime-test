#!/bin/bash
# Скрипт тестирования

set -e

echo "=== Testing Ferma Prime Test ==="

# Run tests
make test

echo "All tests passed!"