package window

when ODIN_OS == .Windows {
	// todo	
} else when ODIN_OS == .Linux {
	when ODIN_ARCH == .arm64 {
		// todo	
	} else {
		foreign import lib {
			"../../lib/libvst.a",
			"system:fontconfig",
			"system:freetype",
			"system:dl",
			"system:gcc_s",
			"system:util",
			"system:rt",
			"system:pthread",
			"system:m",
			"system:c",
		}
	}
}

IncreasePressedCallback :: #type proc "c" (h: rawptr)

@(default_calling_convention="c")
foreign lib {
	app_new					:: proc() -> rawptr ---
	app_run					:: proc(h: rawptr) ---

	app_get_counter			:: proc(h: rawptr) -> i32 ---
	app_set_counter			:: proc(h: rawptr, value: i32) ---
	app_on_increase_pressed	:: proc(h: rawptr, callback: IncreasePressedCallback) ---
}
