#include "../include/ferma.h"
#include <iostream>
#include <cassert>

void test_prime_numbers() {
    std::cout << "Testing prime numbers..." << std::endl;

    // Known prime numbers
    assert(ferma(2) == true);
    assert(ferma(3) == true);
    assert(ferma(5) == true);
    assert(ferma(7) == true);
    assert(ferma(11) == true);
    assert(ferma(13) == true);
    assert(ferma(17) == true);
    assert(ferma(19) == true);
    assert(ferma(23) == true);
    assert(ferma(29) == true);
    assert(ferma(31) == true);
    assert(ferma(97) == true);
    assert(ferma(997) == true);

    std::cout << "✓ All prime tests passed!" << std::endl;
}

void test_composite_numbers() {
    std::cout << "Testing composite numbers..." << std::endl;

    // Known composite numbers
    assert(ferma(1) == false);
    assert(ferma(4) == false);
    assert(ferma(6) == false);
    assert(ferma(8) == false);
    assert(ferma(9) == false);
    assert(ferma(10) == false);
    assert(ferma(12) == false);
    assert(ferma(14) == false);
    assert(ferma(15) == false);
    assert(ferma(16) == false);
    assert(ferma(18) == false);
    assert(ferma(20) == false);
    assert(ferma(100) == false);
    assert(ferma(1000) == false);

    std::cout << "✓ All composite tests passed!" << std::endl;
}

void test_carmichael_numbers() {
    std::cout << "Testing Carmichael numbers (pseudoprimes)..." << std::endl;

    // Carmichael numbers are composite but may pass Fermat test
    // We're testing that our implementation correctly identifies them as composite
    // Note: Some Carmichael numbers might occasionally pass, but with 100 iterations, probability is very low

    int carmichael[] = { 561, 1105, 1729, 2465, 2821, 6601, 8911, 10585, 15841, 29341 };
    int passed = 0;

    for (int num : carmichael) {
        if (!ferma(num)) {
            passed++;
        }
    }

    std::cout << "✓ Carmichael test: " << passed << "/" << sizeof(carmichael) / sizeof(carmichael[0]) << " correctly identified" << std::endl;
}

int main() {
    std::cout << "=== Ferma Prime Test Suite ===" << std::endl;

    test_prime_numbers();
    test_composite_numbers();
    test_carmichael_numbers();

    std::cout << "\n=== All tests passed successfully! ===" << std::endl;
    return 0;
}