# step 1: build the rust application
FROM rust:slim-bullseye AS builder
WORKDIR /app
COPY Cargo.toml ./
RUN mkdir src
COPY src/ src/
RUN cargo build --release

# step 2: create the runtime image
FROM ubuntu:oracular-20240617
WORKDIR /app
RUN apt-get update && apt-get install -y libssl-dev && apt-get clean
COPY --from=builder /app/target/release/minikube . 

# step 3: expose and execute the app
EXPOSE 8000
CMD ["./minikube"]

LABEL org.opencontainers.image.source https://github.com/frankeo/minikube