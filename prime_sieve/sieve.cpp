#include <iostream>
#include <vector>
#include <cmath>

std::vector<int> sieve_of_eratosthenes(int n) {
    if (n < 2) {
        return {};
    }
    
    // Create boolean vector
    std::vector<bool> primes(n + 1, true);
    primes[0] = primes[1] = false;
    
    // Sieve algorithm
    for (int i = 2; i * i <= n; i++) {
        if (primes[i]) {
            for (int j = i * i; j <= n; j += i) {
                primes[j] = false;
            }
        }
    }
    
    // Collect prime numbers
    std::vector<int> result;
    for (int i = 2; i <= n; i++) {
        if (primes[i]) {
            result.push_back(i);
        }
    }
    
    return result;
}

int main() {
    int limit = 10000000;  // 10 million
    std::vector<int> primes = sieve_of_eratosthenes(limit);
    
    std::cout << "Found " << primes.size() << " primes up to " << limit << std::endl;
    std::cout << "First 10 primes: ";
    for (int i = 0; i < 10 && i < primes.size(); i++) {
        std::cout << primes[i] << " ";
    }
    std::cout << std::endl;
    std::cout << "Last 10 primes: ";
    for (int i = primes.size() - 10; i < primes.size(); i++) {
        std::cout << primes[i] << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
