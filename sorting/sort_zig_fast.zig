const std = @import("std");

fn quicksort(arr: []i32, low: usize, high: usize) void {
    if (low < high) {
        const pivot = arr[high];
        var i = low;
        
        var j = low;
        while (j < high) : (j += 1) {
            if (arr[j] <= pivot) {
                const temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
                i += 1;
            }
        }
        
        const temp = arr[i];
        arr[i] = arr[high];
        arr[high] = temp;
        
        const pi = i;
        quicksort(arr, low, pi - 1);
        quicksort(arr, pi + 1, high);
    }
}

pub fn main() !void {
    const size = 1000000;
    var arr = try std.heap.page_allocator.alloc(i32, size);
    defer std.heap.page_allocator.free(arr);
    
    // Simple seeded random for speed
    var seed: u64 = 42;
    for (arr) |*x| {
        seed = (seed *% 1103515245 +% 12345) % 2147483648;
        x.* = @intCast((seed % 1000000) + 1);
    }
    
    quicksort(arr, 0, size - 1);
    
    const stdout = std.io.getStdOut().writer();
    try stdout.print("First 10: ", .{});
    for (arr[0..10]) |x| {
        try stdout.print("{} ", .{x});
    }
    try stdout.print("\nLast 10: ", .{});
    for (arr[size-10..]) |x| {
        try stdout.print("{} ", .{x});
    }
    try stdout.print("\n", .{});
}
