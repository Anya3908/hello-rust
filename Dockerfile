# Этап 1: сборка
FROM rust:1-slim AS builder
WORKDIR /build

COPY Cargo.toml ./
COPY src ./src

RUN cargo build --release

# Этап 2: запуск
FROM debian:stable-slim

RUN useradd --create-home appuser
WORKDIR /home/appuser

COPY --from=builder /build/target/release/hello-rust ./hello-rust
USER appuser

ENTRYPOINT ["./hello-rust"]
