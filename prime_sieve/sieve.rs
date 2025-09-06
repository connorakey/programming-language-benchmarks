use std::collections::VecDeque;

fn sieve_of_eratosthenes(n: usize) -> Vec<i32> {
    if n < 2 {
        return vec![];
    }
    
    // Create boolean vector
    let mut primes = vec![true; n + 1];
    primes[0] = false;
    primes[1] = false;
    
    // Sieve algorithm
    for i in 2..=((n as f64).sqrt() as usize) {
        if primes[i] {
            for j in (i * i..=n).step_by(i) {
                primes[j] = false;
            }
        }
    }
    
    // Collect prime numbers
    let mut result = Vec::new();
    for i in 2..=n {
        if primes[i] {
            result.push(i as i32);
        }
    }
    
    result
}

fn main() {
    let limit = 10_000_000;  // 10 million
    let primes = sieve_of_eratosthenes(limit);
    
    println!("Found {} primes up to {}", primes.len(), limit);
    print!("First 10 primes: ");
    for i in 0..10.min(primes.len()) {
        print!("{} ", primes[i]);
    }
    println!();
    
    print!("Last 10 primes: ");
    for i in (primes.len().saturating_sub(10))..primes.len() {
        print!("{} ", primes[i]);
    }
    println!();
}
