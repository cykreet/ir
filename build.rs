fn main() {
    println!("cargo:rerun-if-changed=ui/window.slint");
    slint_build::compile("ui/window.slint").unwrap();    
}
