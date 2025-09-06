function sieveOfEratosthenes(n) {
    if (n < 2) {
        return [];
    }
    
    // Create boolean array
    const primes = new Array(n + 1).fill(true);
    primes[0] = primes[1] = false;
    
    // Sieve algorithm
    for (let i = 2; i * i <= n; i++) {
        if (primes[i]) {
            for (let j = i * i; j <= n; j += i) {
                primes[j] = false;
            }
        }
    }
    
    // Collect prime numbers
    const result = [];
    for (let i = 2; i <= n; i++) {
        if (primes[i]) {
            result.push(i);
        }
    }
    
    return result;
}

function main() {
    const limit = 10000000;  // 10 million
    const primes = sieveOfEratosthenes(limit);
    
    console.log(`Found ${primes.length} primes up to ${limit}`);
    console.log(`First 10 primes: ${primes.slice(0, 10).join(' ')}`);
    console.log(`Last 10 primes: ${primes.slice(-10).join(' ')}`);
}

main();
