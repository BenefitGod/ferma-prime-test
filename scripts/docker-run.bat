@echo off
echo Starting Docker Desktop...
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
echo.
echo Waiting for Docker to start...
timeout /t 10 /nobreak >nul
echo.
echo Checking Docker status...
docker ps
echo.
echo If Docker is running, you can now build images.
pause