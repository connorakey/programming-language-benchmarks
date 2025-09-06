#!/usr/bin/env python3
import random
import sys

def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quicksort(left) + middle + quicksort(right)

def main():
    # Generate large random array
    size = 1000000  # 1 million elements
    random.seed(42)  # For reproducible results
    arr = [random.randint(1, 1000000) for _ in range(size)]
    
    # Sort the array
    sorted_arr = quicksort(arr)
    
    # Print first and last few elements to verify
    print(f"First 10: {sorted_arr[:10]}")
    print(f"Last 10: {sorted_arr[-10:]}")

if __name__ == "__main__":
    main()
