# K+News

[![Build Status](https://travis-ci.com/sysu-2019-mosad-9/News-Backend.svg?branch=master)](https://travis-ci.com/sysu-2019-mosad-9/News-Backend)

SYSU MOSAD 2019 Group Homework

Backend for iOS app **K+News**, written in Rust

Group Members:

+ Liang Junhua([@Alva112358](https://github.com/Alva112358))
+ Liu Jiahui([@tplish](https://github.com/tplish))
+ Liang Saibo([@dasinlsb](https://github.com/dasinlsb))

## Build & Run

### With Docker

```shell
docker-compose up -d
```

### Without Docker

#### Prerequisites

+ rustup (nightly)
+ postgres

1)Run following command to install executable `diesel`
```shell
cargo install diesel_cli --no-default-features --features postgres
```

2)Make sure postgres is running and you can access it with the configuration in `.env`

```shell
DATABASE_URL=postgres://{username}:{password}@{host_name}/{database_name}
```

3)Setup database:
```shell
diesel setup
```

4)Under the project directory, run server in production mode, which will listen on 0.0.0.0:8000.

`rustup` will choose nightly toolchain according to `rust-toolchain`

```
ROCKET_ENV=production cargo run
```

## API Documentation

REST API documentation is [under another repo](https://github.com/sysu-2019-mosad-9/dev-stage/blob/master/REST-API.md)