package main

import (
	"fmt"
	"math/rand"
)

func quicksort(arr []int) []int {
	if len(arr) <= 1 {
		return arr
	}

	pivot := arr[len(arr)/2]
	var left, middle, right []int

	for _, x := range arr {
		if x < pivot {
			left = append(left, x)
		} else if x > pivot {
			right = append(right, x)
		} else {
			middle = append(middle, x)
		}
	}

	left = quicksort(left)
	right = quicksort(right)

	return append(append(left, middle...), right...)
}

func main() {
	size := 1000000
	rand.Seed(42)

	arr := make([]int, size)
	for i := 0; i < size; i++ {
		arr[i] = rand.Intn(1000000) + 1
	}

	sorted := quicksort(arr)

	fmt.Print("First 10: ")
	for i := 0; i < 10; i++ {
		fmt.Printf("%d ", sorted[i])
	}
	fmt.Println()

	fmt.Print("Last 10: ")
	for i := size - 10; i < size; i++ {
		fmt.Printf("%d ", sorted[i])
	}
	fmt.Println()
}
