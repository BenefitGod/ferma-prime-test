FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY src/ ./src/
COPY include/ ./include/
COPY Makefile ./
COPY scripts/loop.sh ./loop.sh

RUN make clean && make
RUN chmod +x ./loop.sh

EXPOSE 8080

CMD ["./loop.sh"]