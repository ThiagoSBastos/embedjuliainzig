const std = @import("std");

const julia = @cImport({
    @cInclude("julia.h");
});

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    julia.jl_init();
    defer julia.jl_atexit_hook(0);

    _ = julia.jl_eval_string("println(`Hello from Julia`)");
    // _ = julia.jl_eval_string("Hello from Julia");
    const exception = julia.jl_exception_occurred();
    if (exception != null) {
        try stdout.print("An exception occurred in {s} \n", .{"Julia"});
    }
}
