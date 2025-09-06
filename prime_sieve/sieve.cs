using System;
using System.Collections.Generic;

class Program
{
    static List<int> SieveOfEratosthenes(int n)
    {
        if (n < 2)
        {
            return new List<int>();
        }
        
        // Create boolean array
        bool[] primes = new bool[n + 1];
        for (int i = 2; i <= n; i++)
        {
            primes[i] = true;
        }
        
        // Sieve algorithm
        for (int i = 2; i * i <= n; i++)
        {
            if (primes[i])
            {
                for (int j = i * i; j <= n; j += i)
                {
                    primes[j] = false;
                }
            }
        }
        
        // Collect prime numbers
        List<int> result = new List<int>();
        for (int i = 2; i <= n; i++)
        {
            if (primes[i])
            {
                result.Add(i);
            }
        }
        
        return result;
    }
    
    static void Main()
    {
        int limit = 10000000;  // 10 million
        List<int> primes = SieveOfEratosthenes(limit);
        
        Console.WriteLine($"Found {primes.Count} primes up to {limit}");
        Console.Write("First 10 primes: ");
        for (int i = 0; i < 10 && i < primes.Count; i++)
        {
            Console.Write($"{primes[i]} ");
        }
        Console.WriteLine();
        
        Console.Write("Last 10 primes: ");
        for (int i = primes.Count - 10; i < primes.Count; i++)
        {
            Console.Write($"{primes[i]} ");
        }
        Console.WriteLine();
    }
}
