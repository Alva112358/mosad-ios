use crate::db::connection;
use crate::db::model::user_model::UserModel;

use rocket::Route;
use rocket_contrib::json::{Json, JsonValue};
use serde::Deserialize;

#[derive(Deserialize)]
struct RegisterInfo {
    username: String,
    password: String,
}

#[derive(Responder)]
pub enum RegisterResponder {
    #[response(status = 200)]
    Success(JsonValue),
    #[response(status = 403, content_type = "json")]
    Existed(JsonValue),
}

#[post("/users", data = "<info>", format = "json")]
fn register(info: Json<RegisterInfo>) -> RegisterResponder {
    match UserModel::find_by_name(info.0.username.clone(), &connection()) {
        Some(_) => RegisterResponder::Existed(json!({"message": "username already exists"})),
        None => {
            UserModel::create(info.0.username, info.0.password, &connection());
            RegisterResponder::Success(json!({"token": "empty token"}))
        }
    }
}

#[derive(Responder)]
pub enum LoginResponder {
    #[response(status = 200)]
    Success(JsonValue),
    #[response(status = 403, content_type = "json")]
    NoSuchUser(JsonValue),
}

#[post("/login", data = "<info>", format = "json")]
fn login(info: Json<RegisterInfo>) -> LoginResponder {
    match UserModel::auth(info.0.username, info.0.password, &connection()) {
        Some(_u) => LoginResponder::Success(json!({
        "token": "empty token",
        })),
        None => LoginResponder::NoSuchUser(json!({
        "message": "no such user",
        })),
    }
}

pub fn user_routes() -> Vec<Route> {
    routes![register, login]
}
