#include "../include/ferma.h"
#include <iostream>

long long gcd(long long a, long long b) {
    while (b) {
        long long t = b;
        b = a % b;
        a = t;
    }
    return a;
}

long long pows(long long base, long long exp, long long mod) {
    long long result = 1;
    base %= mod;
    while (exp > 0) {
        if (exp & 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exp >>= 1;
    }
    return result;
}

bool ferma(long long x) {
    if (x == 2)
        return true;
    if (x < 2 || x % 2 == 0)
        return false;

    srand(time(NULL));
    for (int i = 0; i < 100; i++) {
        long long a = (rand() % (x - 2)) + 2;
        if (gcd(a, x) != 1)
            return false;
        if (pows(a, x - 1, x) != 1)
            return false;
    }
    return true;
}