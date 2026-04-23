@echo off
echo Building Linux Docker image...
docker build -f Dockerfile.linux -t ferma-test:linux .
echo Done!
pause
