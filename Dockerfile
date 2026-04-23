# Dockerfile для теста Ферма
FROM ubuntu:22.04

# Установка метаданных
LABEL maintainer="n3kit t14g8n0v <voidowich@yandex.ru>"
LABEL description="Ferma Prime Test"
LABEL version="1.0"

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*

# Рабочая директория
WORKDIR /app

# Копирование исходников
COPY src/ ./src/
COPY include/ ./include/
COPY Makefile ./

# Сборка
RUN make clean && make

# Точка входа
ENTRYPOINT ["/app/ferma-test"]
CMD ["--help"]