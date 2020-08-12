###############
### BUILD IMAGE
###############
FROM rustlang/rust:nightly

# Install dependencies
RUN USER=root cargo new --bin /app
WORKDIR /app
COPY Cargo.* ./
COPY rust-toolchain ./
ENV ROCKET_ENV=production
RUN cargo build --release
RUN cargo install diesel_cli --no-default-features --features postgres

# Build server
COPY Rocket.toml ./
COPY diesel.toml ./
COPY .env ./
COPY src ./src
COPY migrations ./migrations
RUN cargo build --release

COPY wait-for-it.sh /
EXPOSE 8000

#################
### RUNTIME IMAGE
#################
#FROM ubuntu:18.04
#
#COPY --from=build /app/target/release/news-backend /
#COPY wait-for-it.sh /
#
#EXPOSE 8000


