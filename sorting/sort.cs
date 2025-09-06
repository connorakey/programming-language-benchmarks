using System;
using System.Collections.Generic;
using System.Linq;

class Program
{
    static List<int> QuickSort(List<int> arr)
    {
        if (arr.Count <= 1)
        {
            return arr;
        }
        
        int pivot = arr[arr.Count / 2];
        var left = new List<int>();
        var middle = new List<int>();
        var right = new List<int>();
        
        foreach (int x in arr)
        {
            if (x < pivot)
            {
                left.Add(x);
            }
            else if (x > pivot)
            {
                right.Add(x);
            }
            else
            {
                middle.Add(x);
            }
        }
        
        left = QuickSort(left);
        right = QuickSort(right);
        
        var result = new List<int>();
        result.AddRange(left);
        result.AddRange(middle);
        result.AddRange(right);
        
        return result;
    }
    
    static void Main()
    {
        int size = 1000000;
        var arr = new List<int>();
        
        Random rand = new Random(42);
        for (int i = 0; i < size; i++)
        {
            arr.Add(rand.Next(1, 1000001));
        }
        
        var sorted = QuickSort(arr);
        
        Console.Write("First 10: ");
        for (int i = 0; i < 10; i++)
        {
            Console.Write(sorted[i] + " ");
        }
        Console.WriteLine();
        
        Console.Write("Last 10: ");
        for (int i = size - 10; i < size; i++)
        {
            Console.Write(sorted[i] + " ");
        }
        Console.WriteLine();
    }
}
