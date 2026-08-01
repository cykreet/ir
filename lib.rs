use paste::paste;
use std::os::raw::c_void;

slint::include_modules!();

macro_rules! expose_i32_property {
    ($App:ty, $prefix:ident, $prop:ident) => {
        paste! {
            #[unsafe(no_mangle)]
            pub extern "C" fn [<$prefix _get_ $prop>](h: *const c_void) -> i32 {
                unsafe { (&*(h as *const $App)).[<get_ $prop>]() }
            }

            #[unsafe(no_mangle)]
            pub extern "C" fn [<$prefix _set_ $prop>](h: *const c_void, v: i32) {
                unsafe { (&*(h as *const $App)).[<set_ $prop>](v) };
            }
        }
    };
}

macro_rules! expose_string_property {
    ($App:ty, $prefix:ident, $prop:ident) => {
        paste! {
            #[unsafe(no_mangle)]
            pub extern "C" fn [<$prefix _set_ $prop>](h: *const c_void, s: *const u8, len: usize) {
                let slice = unsafe { std::slice::from_raw_parts(s, len) };
                let s = std::str::from_utf8(slice).unwrap_or("");
                unsafe { (&*(h as *const $App)).[<set_ $prop>](s.into()) };
            }
        }
    };
}

macro_rules! expose_callback {
    ($App:ty, $prefix:ident, $cb:ident) => {
        paste! {
            #[unsafe(no_mangle)]
            pub extern "C" fn [<$prefix _on_ $cb>](h: *const c_void, f: extern "C" fn()) {
                unsafe { (&*(h as *const $App)).[<on_ $cb>](move || f()) };
            }
        }
    };
}

#[unsafe(no_mangle)]
pub extern "C" fn app_new() ->*mut c_void {
    let app = App::new().expect("failed to create app");
    Box::into_raw(Box::new(app)) as *mut c_void
}

#[unsafe(no_mangle)]
pub extern "C" fn app_run(h: *mut c_void) {
    let app = unsafe { &*(h as *const App) };
    app.run().unwrap();
}

expose_i32_property!(App, app, counter);
// expose_string_property!(App, app, username);
// expose_callback!(App, app, submit_clicked);

// include!("generated.rs");
