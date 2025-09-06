const std = @import("std");

fn fibonacci(n: u32) u128 {
    var a: u128 = 0;
    var b: u128 = 1;
    var i: u32 = 0;
    
    while (i < n) : (i += 1) {
        const temp = a;
        a = b;
        b += temp;
    }
    
    return a;
}

pub fn main() !void {
    const result = fibonacci(100000);
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n", .{result});
}
