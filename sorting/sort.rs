use std::collections::hash_map::DefaultHasher;
use std::hash::{Hash, Hasher};

fn simple_random(seed: &mut u64) -> u64 {
    *seed = (*seed * 9301 + 49297) % 233280;
    *seed
}

fn quicksort(arr: &mut [i32]) {
    if arr.len() <= 1 {
        return;
    }
    
    let pivot = arr[arr.len() / 2];
    let mut left = Vec::new();
    let mut right = Vec::new();
    let mut equal = Vec::new();
    
    for &x in arr.iter() {
        if x < pivot {
            left.push(x);
        } else if x > pivot {
            right.push(x);
        } else {
            equal.push(x);
        }
    }
    
    quicksort(&mut left);
    quicksort(&mut right);
    
    let mut i = 0;
    for &x in left.iter().chain(equal.iter()).chain(right.iter()) {
        arr[i] = x;
        i += 1;
    }
}

fn main() {
    const SIZE: usize = 1_000_000;
    let mut seed = 42u64;
    let mut arr: Vec<i32> = (0..SIZE)
        .map(|_| (simple_random(&mut seed) % 1_000_000 + 1) as i32)
        .collect();
    
    quicksort(&mut arr);
    
    print!("First 10: ");
    for i in 0..10 {
        print!("{} ", arr[i]);
    }
    println!();
    
    print!("Last 10: ");
    for i in (SIZE - 10)..SIZE {
        print!("{} ", arr[i]);
    }
    println!();
}
