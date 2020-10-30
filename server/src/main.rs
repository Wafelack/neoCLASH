use serde_json::*;
use std::fs::File;
use std::io::Write;
use std::net::UdpSocket;

fn main() {
    let localaddr = "127.0.0.1:25368";

    let socket = UdpSocket::bind(localaddr).expect("Failed to bind to ip");

    loop {
        let mut buf = [0; 1024];
        let (number_of_bytes, _src_addr) =
            socket.recv_from(&mut buf).expect("Failed to receive bytes");

        let v: Value =
            serde_json::from_slice(&buf[..number_of_bytes]).expect("Failed to parse header");

        if let Value::String(s) = &v["name"] {
            if let Value::Number(n) = &v["size"] {
                let size = n.as_u64().unwrap_or(0);
                let name = s;
                let mut bytes_received = 0usize;

                let mut content: Vec<u8> = Vec::new();

                while bytes_received < size as usize {
                    let mut tempbuf = [0; 4096];

                    let (b_amount, _src) = socket
                        .recv_from(&mut tempbuf)
                        .expect("Failed to receive bytes");

                    for e in &tempbuf[..b_amount] {
                        content.push(*e);
                    }

                    bytes_received += b_amount;
                }
                let mut f = File::create(name).expect("Failed to create file");
                f.write_all(content.as_slice())
                    .expect("Failed to write in file");
            } else {
                continue;
            }
        } else {
            continue;
        }
    }
}
