using System;

public static class Fibonacci
{
    public static ulong Calculate(int n)
    {
        ulong a = 0, b = 1;
        for (int i = 0; i < n; i++)
        {
            ulong temp = a;
            a = b;
            b += temp;
        }
        return a;
    }
    
    public static void Main()
    {
        ulong result = Calculate(100000);
        Console.WriteLine(result);
    }
}
