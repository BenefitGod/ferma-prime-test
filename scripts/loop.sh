#!/bin/bash
COUNTER=0
while true; do
    COUNTER=$((COUNTER + 1))
    NUMBER=$((RANDOM % 999 + 2))
    echo "[$COUNTER] Testing number: $NUMBER"
    /app/ferma-test $NUMBER
    sleep 2
done