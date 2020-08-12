pub mod model;

use diesel::{Connection, PgConnection};
use dotenv::dotenv;
use std::env;

pub fn connection() -> PgConnection {
    dotenv().ok();
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set in .env");
    PgConnection::establish(&database_url).expect(&format!("Error connecting to {}", database_url))
}
