const std = @import("std");
const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) !void {
    const exe = b.addExecutable("hello", "src/hello.zig");

    const target = b.standardTargetOptions(.{});
    exe.setTarget(target);

    const mode = b.standardReleaseOptions();
    exe.setBuildMode(mode);

    // Setup Julia
    exe.linkLibC();

    const julia_dir = "/path/to/your/julia";
    exe.addIncludePath(julia_dir ++ "/include/julia/");
    exe.addLibraryPath(julia_dir ++ "/lib/");
    exe.linkSystemLibrary("julia");

    const run_step = exe.run();

    const step = b.step("run", "Runs the executable");
    step.dependOn(&run_step.step);
}
