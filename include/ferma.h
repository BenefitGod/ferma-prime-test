#ifndef FERMA_H
#define FERMA_H

#include <cstdlib>
#include <ctime>

// Функция для вычисления НОД
long long gcd(long long a, long long b);

// Функция для быстрого возведения в степень по модулю
long long pows(long long base, long long exp, long long mod);

// Тест Ферма на простоту
bool ferma(long long x);

#endif // FERMA_H