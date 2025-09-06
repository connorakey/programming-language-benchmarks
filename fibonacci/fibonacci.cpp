#include <cstdint>
#include <iostream>

std::uint64_t fibonacci(std::int32_t n) {
    std::uint64_t a = 0, b = 1;
    for (std::int32_t i = 0; i < n; ++i) {
        std::uint64_t temp = a;
        a = b;
        b += temp;
    }
    return a;
}

int main() {
    std::uint64_t result = fibonacci(100000);
    std::cout << result << std::endl;
    return 0;
}