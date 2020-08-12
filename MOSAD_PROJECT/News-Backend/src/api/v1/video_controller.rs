use crate::crawler::video_crawler::craw_video_splider;
use rand::random;
use rocket::http::Status;
use rocket::Route;
use rocket_contrib::json::JsonValue;
#[get("/video/entries?<count>")]
fn get_video_entries(count: usize) -> Result<JsonValue, Status> {
    match craw_video_splider() {
        Ok(video_list) => {
            let mut data: Vec<_> = video_list
                .iter()
                .map(|m| {
                    let n_comment = random::<usize>() % 50;
                    let n_good = n_comment * 5 + random::<usize>() % 100;
                    json!({
                    "id": m.video_id.clone(),
                    "title": m.video_title.clone(),
                    "uploader": m.video_uploader.clone(),
                    "video_preview": m.video_cover_link.clone(),
                    "video_link": m.video_link.clone(),
                    "n_good": n_good,
                    "n_comment": n_comment,
                    })
                })
                .collect();
            loop {
                if data.len() <= count {
                    break;
                }
                data.pop();
            }
            Ok(json!({ "count": count, "data": data, }))
        }
        Err(_e) => Err(Status::InternalServerError),
    }
}

pub fn video_routes() -> Vec<Route> {
    routes![get_video_entries]
}
