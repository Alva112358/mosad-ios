use crate::crawler::news_crawler::{craw_news_detail_splider, craw_news_splider};
use crate::db::connection;
use crate::db::model::news_model::NewsModel;
use rand::{thread_rng, Rng};
use rocket::http::Status;
use rocket::Route;
use rocket_contrib::json::JsonValue;

fn get_tab_names() -> Vec<&'static str> {
    vec!["热点", "社会", "娱乐", "体育"]
}

fn get_tab_name(index: usize) -> Option<String> {
    let tabs = get_tab_names();
    if index < tabs.len() {
        Some(tabs[index].to_owned())
    } else {
        None
    }
}

#[get("/news/tabs", format = "json")]
fn get_base_tabs() -> JsonValue {
    let tabs = vec!["推荐", "时事", "科技", "体育"];
    json!({ "len": tabs.len(), "names": tabs, })
}

#[get("/news/<tab_index>/entries?<count>")]
fn get_news_entries(tab_index: usize, mut count: usize) -> Result<JsonValue, Status> {
    if count > 10 {
        count = 10
    }
    if let Some(tab) = get_tab_name(tab_index) {
        let conn = connection();
        if ensure_data(tab.clone()).is_err() {
            return Err(Status::InternalServerError);
        }
        println!("querying tag: {}, count: {}", tab.clone(), count * 2);
        let mut news_list = NewsModel::find_some_by_tag(tab.clone(), count * 2, &conn);
        println!("found {} news", news_list.len());
        thread_rng().shuffle(&mut news_list);
        if count < news_list.len() {
            count = news_list.len();
        }
        loop {
            if news_list.len() <= count {
                break;
            }
            news_list.pop();
        }
        let data: Vec<_> = news_list
            .iter()
            .flat_map(|news| {
                Some(json!({
                "id": news.news_id.clone(),
                "title": news.news_title.clone(),
                "image_links": news.news_image_urls.clone(),
                "detail_url": format!("/api/v1/news/details/{}", news.news_id.clone()),
                }))
            })
            .collect();
        Ok(json!({ "data": data }))
    } else {
        return Err(Status::BadRequest);
    }
}

#[get("/news/details/<news_index>", format = "json")]
fn get_news_detail(news_index: String) -> Result<JsonValue, Status> {
    match craw_news_detail_splider(news_index) {
        Ok(data) => Ok(json!({
        "title": data.title,
        "body": data.content,
        })),
        Err(_) => Err(Status::BadRequest),
    }
}

#[get("/search?<text>&<count>", format = "json")]
fn search(text: String, count: usize) -> Result<JsonValue, Status> {
    if ensure_all().is_err() {
        return Err(Status::InternalServerError);
    }
    let ret_list = NewsModel::search_some(text.clone(), count, &connection());
    let res: Vec<_> = ret_list
        .iter()
        .map(|r| {
            json!({
            "title": r.news_title.clone(),
            "tag": r.news_tag.clone(),
            "detail_url": format!("/api/v1/news/details/{}", r.news_id.clone()),
            })
        })
        .collect();
    Ok(json!({
    "result": res,
    }))
}

fn ensure_all() -> Result<(), ()> {
    for tab in get_tab_names() {
        ensure_data(tab.to_owned())?;
    }
    Ok(())
}

fn ensure_data(tag: String) -> Result<(), ()> {
    let conn = connection();
    let cur_time = chrono::Utc::now().naive_utc();
    //println!("current time: {:?}", &cur_time);
    if match NewsModel::find_latest_crawl_time(tag.clone(), &conn) {
        Some(last_crawl_time)
            if cur_time
                .signed_duration_since(last_crawl_time)
                .num_minutes()
                > 30 =>
        {
            //println!("last crawl time: {:?}", &last_crawl_time);
            true
        }
        None => true,
        _ => false,
    } {
        println!("crawling new data for tag: {}...", tag.as_str());
        match craw_news_splider(tag.clone()) {
            Ok(news_list) => {
                println!("crawled {} news", news_list.len());
                for news in &news_list {
                    //println!("will save news: {:?}", news);
                    news.save(&conn);
                }
                NewsModel::clean_old(tag.clone(), &conn);
            }
            Err(e) => {
                eprintln!("craw error: {:?}", e);
                return Err(());
            }
        }
    }
    Ok(())
}

pub fn news_routes() -> Vec<Route> {
    routes![get_base_tabs, get_news_entries, get_news_detail, search]
}
