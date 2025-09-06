import java.util.ArrayList;
import java.util.List;

public class Sieve {
    public static List<Integer> sieveOfEratosthenes(int n) {
        if (n < 2) {
            return new ArrayList<>();
        }
        
        // Create boolean array
        boolean[] primes = new boolean[n + 1];
        for (int i = 2; i <= n; i++) {
            primes[i] = true;
        }
        
        // Sieve algorithm
        for (int i = 2; i * i <= n; i++) {
            if (primes[i]) {
                for (int j = i * i; j <= n; j += i) {
                    primes[j] = false;
                }
            }
        }
        
        // Collect prime numbers
        List<Integer> result = new ArrayList<>();
        for (int i = 2; i <= n; i++) {
            if (primes[i]) {
                result.add(i);
            }
        }
        
        return result;
    }
    
    public static void main(String[] args) {
        int limit = 10000000;  // 10 million
        List<Integer> primes = sieveOfEratosthenes(limit);
        
        System.out.println("Found " + primes.size() + " primes up to " + limit);
        System.out.print("First 10 primes: ");
        for (int i = 0; i < 10 && i < primes.size(); i++) {
            System.out.print(primes.get(i) + " ");
        }
        System.out.println();
        
        System.out.print("Last 10 primes: ");
        for (int i = primes.size() - 10; i < primes.size(); i++) {
            System.out.print(primes.get(i) + " ");
        }
        System.out.println();
    }
}
