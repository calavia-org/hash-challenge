# Build Stage
FROM liuchong/rustup AS builder
WORKDIR /app
RUN rustup default nightly

COPY Cargo.toml Cargo.lock ./
COPY src ./src
RUN cargo build --release 
RUN find /app | grep challenge
# Bundle Stage
FROM scratch
COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/hash-challenge .
USER 1000
CMD ["./hash-challenge", "-a", "0.0.0.0", "-p", "8080"]




#ADD src /app
#WORKDIR /app
#COPY Cargo.toml Cargo.lock ./
#
#RUN rustup default nightly
#RUN cargo build --release
#
## Bundle Stage
#FROM scratch
#COPY --from=builder /app/target/release/hero-api .
#USER 1000
#CMD ["./hero-api", "-a", "0.0.0.0", "-p", "8080"]
