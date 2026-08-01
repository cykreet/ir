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

@(default_calling_convention="c")
foreign lib {
	app_new :: proc() -> rawptr ---
	app_run :: proc(h: rawptr) ---
}
