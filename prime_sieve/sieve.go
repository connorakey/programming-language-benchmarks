package main

import (
	"fmt"
)

func sieveOfEratosthenes(n int) []int {
	if n < 2 {
		return []int{}
	}

	// Create boolean slice
	primes := make([]bool, n+1)
	for i := 2; i <= n; i++ {
		primes[i] = true
	}

	// Sieve algorithm
	for i := 2; i*i <= n; i++ {
		if primes[i] {
			for j := i * i; j <= n; j += i {
				primes[j] = false
			}
		}
	}

	// Collect prime numbers
	var result []int
	for i := 2; i <= n; i++ {
		if primes[i] {
			result = append(result, i)
		}
	}

	return result
}

func main() {
	limit := 10000000 // 10 million
	primes := sieveOfEratosthenes(limit)

	fmt.Printf("Found %d primes up to %d\n", len(primes), limit)
	fmt.Print("First 10 primes: ")
	for i := 0; i < 10 && i < len(primes); i++ {
		fmt.Printf("%d ", primes[i])
	}
	fmt.Println()

	fmt.Print("Last 10 primes: ")
	for i := len(primes) - 10; i < len(primes); i++ {
		fmt.Printf("%d ", primes[i])
	}
	fmt.Println()
}
