FROM rust:1.65 as build

RUN USER=root cargo new --bin main
WORKDIR /main

COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml
RUN cargo build --release

RUN rm src/*.rs
COPY ./src ./src

RUN rm ./target/release/deps/main*
RUN cargo build --release

FROM debian:buster-slim
COPY --from=build /main/target/release/main .

CMD ["./main"]