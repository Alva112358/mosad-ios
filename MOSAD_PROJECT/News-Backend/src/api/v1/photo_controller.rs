use crate::crawler::photo_crawler::craw_photo_splider;
use rocket::http::Status;
use rocket::Route;
use rocket_contrib::json::JsonValue;

#[get("/photo/entries?<count>", format = "json")]
fn get_photo_entries(count: usize) -> Result<JsonValue, Status> {
    if count > 15 {
        return Err(Status::BadRequest);
    }
    match craw_photo_splider(count) {
        Ok(photo_list) => {
            let data: Vec<_> = photo_list
                .iter()
                .map(|m| {
                    json!({
                    "image_link": m.photo_link.clone(),
                    })
                })
                .collect();
            Ok(json!({ "count": count, "data": data, }))
        }
        Err(e) => {
            eprintln!("craw photo error: {:?}", e);
            Err(Status::InternalServerError)
        }
    }
}

pub fn photo_routes() -> Vec<Route> {
    routes![get_photo_entries]
}
