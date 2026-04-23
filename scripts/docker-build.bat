@echo off
echo ========================================
echo Building Docker Image for Windows
echo ========================================
echo.

REM Проверка наличия Docker
where docker >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not installed!
    echo.
    echo Please install Docker Desktop from:
    echo https://www.docker.com/products/docker-desktop/
    echo.
    pause
    exit /b 1
)

REM Проверка, запущен ли Docker
echo Checking Docker status...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not running!
    echo.
    echo Please start Docker Desktop from Start Menu
    echo Wait for the Docker icon to appear in system tray
    echo.
    pause
    exit /b 1
)

echo Docker is running!
echo.

REM Проверка наличия Dockerfile
if not exist Dockerfile.linux (
    if not exist Dockerfile (
        echo [ERROR] No Dockerfile found!
        echo.
        echo Please create Dockerfile.linux or Dockerfile
        echo.
        pause
        exit /b 1
    )
)

REM Сборка образа
echo Building Docker image...
echo.

if exist Dockerfile.linux (
    echo Using Dockerfile.linux...
    docker build -f Dockerfile.linux -t ferma-test:latest .
) else (
    echo Using Dockerfile...
    docker build -t ferma-test:latest .
)

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo [SUCCESS] Docker image built successfully!
    echo ========================================
    echo.
    echo Image: ferma-test:latest
    echo.
    echo To run: docker run --rm ferma-test:latest 17
    echo To test: docker run --rm ferma-test:latest 97
    echo.
) else (
    echo.
    echo ========================================
    echo [FAILED] Docker build failed!
    echo ========================================
    echo.
    echo Check the error messages above.
    echo.
)

pause