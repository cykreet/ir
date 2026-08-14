package vst

import window "window"
import clap "clap:clap/bindings/clap"

main :: proc() {
	app := window.app_new()
	window.app_run(app)

	clap.CLAP_VERSION
}
