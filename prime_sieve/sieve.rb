def sieve_of_eratosthenes(n)
  return [] if n < 2
  
  # Create boolean array
  primes = Array.new(n + 1, true)
  primes[0] = primes[1] = false
  
  # Sieve algorithm
  (2..Math.sqrt(n).to_i).each do |i|
    if primes[i]
      (i * i).step(n, i) do |j|
        primes[j] = false
      end
    end
  end
  
  # Collect prime numbers
  result = []
  (2..n).each do |i|
    result << i if primes[i]
  end
  
  result
end

def main
  limit = 10000000  # 10 million
  primes = sieve_of_eratosthenes(limit)
  
  puts "Found #{primes.length} primes up to #{limit}"
  puts "First 10 primes: #{primes.first(10).join(' ')}"
  puts "Last 10 primes: #{primes.last(10).join(' ')}"
end

main
