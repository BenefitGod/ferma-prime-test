FROM ubuntu:22.04
LABEL maintainer="n3kit t14g8n0v <voidowich@yandex.ru>"
LABEL description="Ferma Prime Test"
LABEL version="1.0"
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY src/ ./src/
COPY include/ ./include/
COPY Makefile ./
RUN make clean && make
ENTRYPOINT ["/app/ferma-test"]
CMD ["--help"]