export function fibonacci(n: number): number {
    let a = 0, b = 1;
    for (let i = 0; i < n; i++) {
        [a, b] = [b, a + b];
    }
    return a;
}

export const fibResult = fibonacci(100000);
console.log(fibResult);
