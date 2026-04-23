#!/bin/bash
# Скрипт для создания релизной версии

set -e

VERSION=$1
if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 v1.0.0"
    exit 1
fi

echo "Creating release $VERSION"

# Обновление версии в файлах
sed -i "s/Version: .*/Version: ${VERSION}/g" debian/ferma-test/DEBIAN/control

# Коммит изменений
git add debian/ferma-test/DEBIAN/control
git commit -m "Bump version to ${VERSION}"

# Создание тега
git tag -a "${VERSION}" -m "Release ${VERSION}"

# Отправка в GitLab
git push origin main
git push origin "${VERSION}"

echo "Release ${VERSION} created!"
echo "CI/CD pipeline will automatically build and deploy"