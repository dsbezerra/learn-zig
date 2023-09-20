const std = @import("std");
const expect = std.testing.expect;

pub fn solution(n: isize) usize {
    if (n < 1 or n > 2_147_483_647) return 0;

    var buf: [32]u8 = undefined; // 32 is enough
    const binary = std.fmt.bufPrint(&buf, "{b}", .{n}) catch return 0;

    var result: usize = 0;

    var seen_one = false;
    var len: usize = 0;

    for (binary) |bit| {
        switch (bit) {
            '0' => {
                if (seen_one) {
                    len += 1;
                }
            },
            '1' => {
                if (!seen_one) {
                    seen_one = true;
                } else {
                    if (len > 0) {
                        if (len > result) {
                            result = len;
                        }
                        len = 0;
                    }
                }
            },
            else => {},
        }
    }

    return result;
}

test "binary gap" {
    try expect(solution(9) == 2);
    try expect(solution(529) == 4);
    try expect(solution(20) == 1);
    try expect(solution(15) == 0);
    try expect(solution(32) == 0);
    try expect(solution(1041) == 5);
}
