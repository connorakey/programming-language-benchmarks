const std = @import("std");

fn sieveOfEratosthenes(allocator: std.mem.Allocator, n: usize) ![]usize {
    if (n < 2) {
        return allocator.alloc(usize, 0);
    }
    
    // Create boolean array
    var primes = try allocator.alloc(bool, n + 1);
    defer allocator.free(primes);
    
    for (primes) |*prime| {
        prime.* = true;
    }
    primes[0] = false;
    primes[1] = false;
    
    // Sieve algorithm
    var i: usize = 2;
    while (i * i <= n) : (i += 1) {
        if (primes[i]) {
            var j = i * i;
            while (j <= n) : (j += i) {
                primes[j] = false;
            }
        }
    }
    
    // Count primes
    var count: usize = 0;
    for (primes) |prime| {
        if (prime) count += 1;
    }
    
    // Create result array
    var result = try allocator.alloc(usize, count);
    var index: usize = 0;
    for (primes, 0..) |prime, k| {
        if (prime) {
            result[index] = k;
            index += 1;
        }
    }
    
    return result;
}

pub fn main() !void {
    const limit = 10_000_000;  // 10 million
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    
    const primes = try sieveOfEratosthenes(allocator, limit);
    defer allocator.free(primes);
    
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Found {} primes up to {}\n", .{ primes.len, limit });
    
    try stdout.print("First 10 primes: ", .{});
    for (primes[0..@min(10, primes.len)]) |prime| {
        try stdout.print("{} ", .{prime});
    }
    try stdout.print("\n", .{});
    
    try stdout.print("Last 10 primes: ", .{});
    const start = if (primes.len >= 10) primes.len - 10 else 0;
    for (primes[start..]) |prime| {
        try stdout.print("{} ", .{prime});
    }
    try stdout.print("\n", .{});
}
