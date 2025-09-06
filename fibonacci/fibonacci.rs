fn fibonacci(n: u32) -> u64 {
    let mut a = 0u64;
    let mut b = 1u64;
    for _ in 0..n {
        let temp = a;
        a = b;
        b += temp;
    }
    a
}

fn main() {
    let result = fibonacci(100000);
    println!("{}", result);
}