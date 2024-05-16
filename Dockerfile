
FROM rust:1.78.0 as builder

WORKDIR /usr/src/app
COPY Cargo.toml Cargo.lock ./
COPY src ./src
RUN cargo build --release
FROM debian:buster-slim

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/target/release/rust-service .

ENV RUST_LOG=info
EXPOSE 8080
CMD ["./rust-service"]
