#include "../include/ferma.h"
#include <iostream>
using namespace std;

int main(int argc, char* argv[]) {
    long long number;

    if (argc > 1) {
        number = atoll(argv[1]);
    }
    else {
        cout << "Enter a number to test: ";
        cin >> number;
    }

    cout << "Testing number: " << number << endl;

    if (ferma(number))
        cout << number << " is probably prime" << endl;
    else
        cout << number << " is composite" << endl;

    return 0;
}