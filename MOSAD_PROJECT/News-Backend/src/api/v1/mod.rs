mod news_controller;
mod photo_controller;
mod user_controller;
mod video_controller;

use rocket::Route;

pub fn routes() -> Vec<Route> {
    let routes_list = vec![
        news_controller::news_routes(),
        photo_controller::photo_routes(),
        video_controller::video_routes(),
        user_controller::user_routes(),
    ];
    routes_list.into_iter().flatten().collect()
}
