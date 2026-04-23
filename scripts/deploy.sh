#!/bin/bash
# Скрипт деплоя (для релизных версий)

set -e

VERSION=${CI_COMMIT_TAG:-$(git describe --tags --always)}
PACKAGE_NAME="ferma-test_${VERSION}_amd64.deb"

echo "=== Deploying Ferma Prime Test v${VERSION} ==="

# Create release directory
mkdir -p release

# Copy package to release directory
cp ${PACKAGE_NAME} release/
cp ferma-test release/ || true
cp README.md release/

# Generate checksums
cd release
sha256sum ${PACKAGE_NAME} > ${PACKAGE_NAME}.sha256
md5sum ${PACKAGE_NAME} > ${PACKAGE_NAME}.md5

echo "Deployment files prepared in release/ directory"
ls -la

# For GitLab Pages or artifact storage
echo "CI_JOB_NAME: ${CI_JOB_NAME}"
echo "CI_COMMIT_TAG: ${CI_COMMIT_TAG}"