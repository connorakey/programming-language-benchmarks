#!/usr/bin/env python3
import math

def sieve_of_eratosthenes(n):
    """Find all primes up to n using Sieve of Eratosthenes"""
    if n < 2:
        return []
    
    # Create boolean array, initially all True
    primes = [True] * (n + 1)
    primes[0] = primes[1] = False
    
    # Sieve algorithm
    for i in range(2, int(math.sqrt(n)) + 1):
        if primes[i]:
            for j in range(i * i, n + 1, i):
                primes[j] = False
    
    # Collect prime numbers
    result = []
    for i in range(2, n + 1):
        if primes[i]:
            result.append(i)
    
    return result

def main():
    limit = 10000000  # 10 million
    primes = sieve_of_eratosthenes(limit)
    
    print(f"Found {len(primes)} primes up to {limit}")
    print(f"First 10 primes: {primes[:10]}")
    print(f"Last 10 primes: {primes[-10:]}")

if __name__ == "__main__":
    main()
