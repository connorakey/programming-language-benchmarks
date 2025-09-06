#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>

int* sieve_of_eratosthenes(int n, int* count) {
    if (n < 2) {
        *count = 0;
        return NULL;
    }
    
    // Create boolean array
    bool* primes = (bool*)calloc(n + 1, sizeof(bool));
    for (int i = 2; i <= n; i++) {
        primes[i] = true;
    }
    
    // Sieve algorithm
    for (int i = 2; i * i <= n; i++) {
        if (primes[i]) {
            for (int j = i * i; j <= n; j += i) {
                primes[j] = false;
            }
        }
    }
    
    // Count primes
    *count = 0;
    for (int i = 2; i <= n; i++) {
        if (primes[i]) {
            (*count)++;
        }
    }
    
    // Create result array
    int* result = (int*)malloc(*count * sizeof(int));
    int index = 0;
    for (int i = 2; i <= n; i++) {
        if (primes[i]) {
            result[index++] = i;
        }
    }
    
    free(primes);
    return result;
}

int main() {
    int limit = 10000000;  // 10 million
    int count;
    int* primes = sieve_of_eratosthenes(limit, &count);
    
    printf("Found %d primes up to %d\n", count, limit);
    printf("First 10 primes: ");
    for (int i = 0; i < 10 && i < count; i++) {
        printf("%d ", primes[i]);
    }
    printf("\nLast 10 primes: ");
    for (int i = count - 10; i < count; i++) {
        printf("%d ", primes[i]);
    }
    printf("\n");
    
    free(primes);
    return 0;
}
