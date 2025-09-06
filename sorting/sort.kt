import java.util.Random

fun quicksort(arr: List<Int>): List<Int> {
    if (arr.size <= 1) {
        return arr
    }
    
    val pivot = arr[arr.size / 2]
    val left = arr.filter { it < pivot }
    val middle = arr.filter { it == pivot }
    val right = arr.filter { it > pivot }
    
    return quicksort(left) + middle + quicksort(right)
}

fun main() {
    val size = 1000000
    val arr = mutableListOf<Int>()
    
    val rand = Random(42)
    repeat(size) {
        arr.add(rand.nextInt(1000000) + 1)
    }
    
    val sorted = quicksort(arr)
    
    print("First 10: ")
    for (i in 0 until 10) {
        print("${sorted[i]} ")
    }
    println()
    
    print("Last 10: ")
    for (i in size - 10 until size) {
        print("${sorted[i]} ")
    }
    println()
}
