package main

import "fmt"

func fibonacci(n int) uint64 {
	a, b := uint64(0), uint64(1)
	for i := 0; i < n; i++ {
		a, b = b, a+b
	}
	return a
}

func main() {
	result := fibonacci(100000)
	fmt.Println(result)
}
