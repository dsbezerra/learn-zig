const std = @import("std");
const expectEqualSlices = std.testing.expectEqualSlices;

pub fn solution(a: []const i64, k: usize) []const i64 {
    if (a.len < 0 or a.len > 100 or k < 0 or k > 100) return a;

    var result = std.heap.page_allocator.alloc(i64, a.len) catch unreachable;

    const rot = k % a.len;

    for (a, 0..) |_, i| {
        result[(i + rot) % a.len] = a[i];
    }

    return result[0..a.len];
}

test "cyclic rotation" {
    try expectEqualSlices(i64, &[_]i64{ 9, 7, 6, 3, 8 }, solution(&[_]i64{ 3, 8, 9, 7, 6 }, 3));
    try expectEqualSlices(i64, &[_]i64{ 0, 0, 0 }, solution(&[_]i64{ 0, 0, 0 }, 1));
    try expectEqualSlices(i64, &[_]i64{ 1, 2, 3, 4 }, solution(&[_]i64{ 1, 2, 3, 4 }, 4));
}
