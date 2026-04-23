#!/bin/bash
# Скрипт упаковки

set -e

VERSION=${CI_COMMIT_TAG:-$(git describe --tags --always)}
PACKAGE_NAME="ferma-test_${VERSION}_amd64.deb"

echo "=== Packaging Ferma Prime Test v${VERSION} ==="

# Create package structure
mkdir -p debian/ferma-test/usr/local/bin
mkdir -p debian/ferma-test/usr/share/doc/ferma-test
mkdir -p debian/ferma-test/DEBIAN

# Copy binary
cp ferma-test debian/ferma-test/usr/local/bin/
chmod 755 debian/ferma-test/usr/local/bin/ferma-test

# Create control file
cat > debian/ferma-test/DEBIAN/control << EOF
Package: ferma-test
Version: ${VERSION}
Section: math
Priority: optional
Architecture: amd64
Essential: no
Depends: libc6
Maintainer: ${GITLAB_USER_NAME:-CI/CD} <${GITLAB_USER_EMAIL:-ci@example.com}>
Description: Ferma prime test
 A program for testing prime numbers using Fermat's theorem.
 It provides a probabilistic primality test with 100 iterations.
Homepage: ${CI_PROJECT_URL:-https://gitlab.com}
EOF

# Create postinst script
cat > debian/ferma-test/DEBIAN/postinst << 'EOF'
#!/bin/bash
set -e
echo "Ferma Prime Test installed successfully!"
echo "Run 'ferma-test' to test numbers for primality."
exit 0
EOF

chmod 755 debian/ferma-test/DEBIAN/postinst

# Copy documentation
cp README.md debian/ferma-test/usr/share/doc/ferma-test/ || true
cp LICENSE debian/ferma-test/usr/share/doc/ferma-test/copyright || true

# Build package
dpkg-deb --build debian/ferma-test
mv debian/ferma-test.deb ${PACKAGE_NAME}

echo "Package created: ${PACKAGE_NAME}"
ls -la ${PACKAGE_NAME}