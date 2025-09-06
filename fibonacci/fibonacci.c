#include <stdio.h>
#include <stdint.h>

uint64_t fibonacci(int32_t n) {
    uint64_t a = 0, b = 1;
    for (int32_t i = 0; i < n; i++) {
        uint64_t temp = a;
        a = b;
        b += temp;
    }
    return a;
}

int main() {
    uint64_t result = fibonacci(100000);
    printf("%llu\n", result);
    return 0;
}