use lines_from_file::lines_from_file;
use std::net::UdpSocket;
use std::path::Path;

fn main() {
    let args: Vec<String> = std::env::args().collect();

    if args.len() != 3 {
        println!("Usage : filet <filename> <dest>");
        std::process::exit(65);
    }

    if !Path::new(&args[1]).exists() {
        println!("File not found");
        std::process::exit(25);
    }

    let local = "127.0.0.1:10101";

    let socket = UdpSocket::bind(local).expect("Failed to bind ip");
    println!("[+] Successfully binded to {}", local);

    socket
        .connect(&args[2].trim())
        .expect("Cannot connect to ip. Verify if the server is installed on the target machine");
    println!("[+] Successfully connected to {}", local);

    let content = format!("{}|{}", &args[1], lines_from_file(&args[1]).join("\n"));
    socket
        .send(content.as_bytes())
        .expect("Failed to send file");
    println!("[+] File sent sucessfully");
}
