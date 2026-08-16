package vst

import "base:runtime"
import "core:fmt"
import window "window"
import clap "deps:clap"

on_increase_pressed :: proc(h: rawptr) {
	count := window.app_get_counter(h)
	window.app_set_counter(h, count + 1)
}

main :: proc() {
	fmt.printfln("using clap version: %i.%i.%i", clap.CLAP_VERSION.major, clap.CLAP_VERSION.minor, clap.CLAP_VERSION.revision)

	app := window.app_new()
	window.app_on_increase_pressed(app, proc "c" (h: rawptr) {
		context = runtime.default_context()
		on_increase_pressed(h)
	})

	window.app_run(app)
}
