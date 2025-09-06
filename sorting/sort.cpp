#include <iostream>
#include <vector>
#include <random>
#include <algorithm>

void quicksort(std::vector<int>& arr, int low, int high) {
    if (low < high) {
        int pivot = arr[high];
        int i = low - 1;
        
        for (int j = low; j < high; j++) {
            if (arr[j] <= pivot) {
                i++;
                std::swap(arr[i], arr[j]);
            }
        }
        
        std::swap(arr[i + 1], arr[high]);
        int pi = i + 1;
        
        quicksort(arr, low, pi - 1);
        quicksort(arr, pi + 1, high);
    }
}

int main() {
    const int size = 1000000;
    std::vector<int> arr(size);
    
    std::mt19937 gen(42);
    std::uniform_int_distribution<> dis(1, 1000000);
    
    for (int i = 0; i < size; i++) {
        arr[i] = dis(gen);
    }
    
    quicksort(arr, 0, size - 1);
    
    std::cout << "First 10: ";
    for (int i = 0; i < 10; i++) {
        std::cout << arr[i] << " ";
    }
    std::cout << "\nLast 10: ";
    for (int i = size - 10; i < size; i++) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
