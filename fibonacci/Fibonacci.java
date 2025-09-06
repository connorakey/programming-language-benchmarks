public class Fibonacci {
    public static long fibonacci(int n) {
        long a = 0, b = 1;
        for (int i = 0; i < n; i++) {
            long temp = a;
            a = b;
            b += temp;
        }
        return a;
    }
    
    public static void main(String[] args) {
        long result = fibonacci(100000);
        System.out.println(result);
    }
}