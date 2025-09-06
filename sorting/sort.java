import java.util.Random;
import java.util.ArrayList;
import java.util.List;

public class Sort {
    public static List<Integer> quicksort(List<Integer> arr) {
        if (arr.size() <= 1) {
            return arr;
        }
        
        int pivot = arr.get(arr.size() / 2);
        List<Integer> left = new ArrayList<>();
        List<Integer> middle = new ArrayList<>();
        List<Integer> right = new ArrayList<>();
        
        for (int x : arr) {
            if (x < pivot) {
                left.add(x);
            } else if (x > pivot) {
                right.add(x);
            } else {
                middle.add(x);
            }
        }
        
        left = quicksort(left);
        right = quicksort(right);
        
        List<Integer> result = new ArrayList<>();
        result.addAll(left);
        result.addAll(middle);
        result.addAll(right);
        
        return result;
    }
    
    public static void main(String[] args) {
        int size = 1000000;
        Random rand = new Random(42);
        List<Integer> arr = new ArrayList<>();
        
        for (int i = 0; i < size; i++) {
            arr.add(rand.nextInt(1000000) + 1);
        }
        
        List<Integer> sorted = quicksort(arr);
        
        System.out.print("First 10: ");
        for (int i = 0; i < 10; i++) {
            System.out.print(sorted.get(i) + " ");
        }
        System.out.println();
        
        System.out.print("Last 10: ");
        for (int i = size - 10; i < size; i++) {
            System.out.print(sorted.get(i) + " ");
        }
        System.out.println();
    }
}
