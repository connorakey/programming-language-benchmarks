fun sieveOfEratosthenes(n: Int): List<Int> {
    if (n < 2) {
        return emptyList()
    }
    
    // Create boolean array
    val primes = BooleanArray(n + 1) { true }
    primes[0] = false
    primes[1] = false
    
    // Sieve algorithm
    for (i in 2..kotlin.math.sqrt(n.toDouble()).toInt()) {
        if (primes[i]) {
            for (j in (i * i)..n step i) {
                primes[j] = false
            }
        }
    }
    
    // Collect prime numbers
    val result = mutableListOf<Int>()
    for (i in 2..n) {
        if (primes[i]) {
            result.add(i)
        }
    }
    
    return result
}

fun main() {
    val limit = 10000000  // 10 million
    val primes = sieveOfEratosthenes(limit)
    
    println("Found ${primes.size} primes up to $limit")
    print("First 10 primes: ")
    for (i in 0 until 10.coerceAtMost(primes.size)) {
        print("${primes[i]} ")
    }
    println()
    
    print("Last 10 primes: ")
    for (i in (primes.size - 10).coerceAtLeast(0) until primes.size) {
        print("${primes[i]} ")
    }
    println()
}
