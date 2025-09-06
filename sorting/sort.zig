const std = @import("std");

fn quicksort(arr: []i32) void {
    if (arr.len <= 1) return;
    
    const pivot = arr[arr.len / 2];
    var left = std.ArrayList(i32).init(std.heap.page_allocator);
    var middle = std.ArrayList(i32).init(std.heap.page_allocator);
    var right = std.ArrayList(i32).init(std.heap.page_allocator);
    
    for (arr) |x| {
        if (x < pivot) {
            left.append(x) catch return;
        } else if (x > pivot) {
            right.append(x) catch return;
        } else {
            middle.append(x) catch return;
        }
    }
    
    quicksort(left.items);
    quicksort(right.items);
    
    var i: usize = 0;
    for (left.items) |x| {
        arr[i] = x;
        i += 1;
    }
    for (middle.items) |x| {
        arr[i] = x;
        i += 1;
    }
    for (right.items) |x| {
        arr[i] = x;
        i += 1;
    }
}

pub fn main() !void {
    const size = 1000000;
    var arr = try std.heap.page_allocator.alloc(i32, size);
    defer std.heap.page_allocator.free(arr);
    
    var rng = std.Random.DefaultPrng.init(42);
    for (arr) |*x| {
        x.* = rng.random().intRangeAtMost(i32, 1, 1000000);
    }
    
    quicksort(arr);
    
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
