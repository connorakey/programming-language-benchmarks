<?php

function sieveOfEratosthenes($n) {
    if ($n < 2) {
        return array();
    }
    
    // Create boolean array
    $primes = array_fill(0, $n + 1, true);
    $primes[0] = $primes[1] = false;
    
    // Sieve algorithm
    for ($i = 2; $i * $i <= $n; $i++) {
        if ($primes[$i]) {
            for ($j = $i * $i; $j <= $n; $j += $i) {
                $primes[$j] = false;
            }
        }
    }
    
    // Collect prime numbers
    $result = array();
    for ($i = 2; $i <= $n; $i++) {
        if ($primes[$i]) {
            $result[] = $i;
        }
    }
    
    return $result;
}

function main() {
    $limit = 1000000;  // 1 million (reduced for memory constraints)
    $primes = sieveOfEratosthenes($limit);
    
    echo "Found " . count($primes) . " primes up to " . $limit . "\n";
    echo "First 10 primes: " . implode(" ", array_slice($primes, 0, 10)) . "\n";
    echo "Last 10 primes: " . implode(" ", array_slice($primes, -10)) . "\n";
}

main();

?>
