package main

import "core:os"
import "core:fmt"

run_cmd :: proc(args: []string) -> bool {
	desc := os.Process_Desc { command = args }
	process, start_err := os.process_start(desc)
	if start_err != nil {
		fmt.eprintfln("error: failed to start %v: %v", args, start_err)
		return false
	}

	state, wait_err := os.process_wait(process)
	if wait_err != nil {
		fmt.eprintfln("error: failed waiting on %v: %v", args, wait_err)
		return false
	}

	return state.exit_code == 0
}

copy_file :: proc(src, dest: string) -> bool {
	data, read_err := os.read_entire_file_from_path(src, allocator = context.allocator)
	if read_err != nil {
		fmt.eprintfln("error: could not read %s", src)
		return false
	}

	defer delete(data)
	return os.write_entire_file(dest, data) != nil
}

main :: proc() {
	os.make_directory("lib")

	if !run_cmd([]string{ "cargo", "build", "--release" }) {
		fmt.eprintfln("error: cargo build failed")
		os.exit(1)
	}

	if !copy_file("target/release/libvst.a", "lib/libvst.a") {
		os.exit(1)
	}

	if !run_cmd([]string{ "odin", "build", "src", "-out:build/ir" }) {
		fmt.eprintfln("error: odin build failed")
		os.exit(1)
	}

	fmt.println("build complete")
}

