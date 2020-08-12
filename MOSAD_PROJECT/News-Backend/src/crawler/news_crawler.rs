use crate::db::model::news_detail_model::NewsDetailModel;
use crate::db::model::news_model::NewsModel;
use crate::error::ServerError::StrError;

use dotenv::dotenv;
use reqwest::header::{COOKIE, USER_AGENT};
use std::error::Error;

#[derive(Clone, Deserialize)]
struct SpliderNewsImg {
    url: String,
}

#[derive(Deserialize)]
struct SpliderNews {
    item_id: String,
    tag: String,
    article_url: String,
    article_type: i32,
    datetime: String,
    image_list: Vec<SpliderNewsImg>, // list/pgc-image/[id]
    title: String,
}

fn no_img() -> String {
    String::from("http://imgs.xueui.cn/wp-content/uploads/2015/12/235R92444-3.jpg")
}

pub fn craw_news_splider(tag: String) -> Result<Vec<NewsModel>, Box<dyn Error>> {
    dotenv().ok();
    let tag_names = [
        "热点", "社会", "娱乐", "体育", "美文", "科技", "财经", "时尚",
    ];
    let tag_urls = [
        "http://m.toutiao.com/list/?tag=news_hot&ac=wap&count=20&format=json_raw&as=A1A59982B911729&cp=5929E12752796E1&min_behot_time=0",
        "http://m.toutiao.com/list/?tag=news_society&ac=wap&count=20&format=json_raw&as=A195B9F229018CD&cp=592991783C9D8E1&min_behot_time=0",
        "http://m.toutiao.com/list/?tag=news_entertainment&ac=wap&count=20&format=json_raw&as=A1C51992996195E&cp=5929D119B58EFE1&min_behot_time=0",
        "http://m.toutiao.com/list/?tag=news_sports&ac=wap&count=20&format=json_raw&as=A1054902B911A1E&cp=592991AA81AEAE1&min_behot_time=0",
        "http://m.toutiao.com/list/?tag=news_essay&ac=wap&count=20&format=json_raw&as=A195495279C19DE&cp=5929C1F91DFEEE1&min_behot_time=0",
        "http://m.toutiao.com/list/?tag=news_tech&ac=wap&count=20&format=json_raw&as=A1854972BABC6FF&cp=592A9CC64FCFAE1&max_behot_time=0",
        "http://m.toutiao.com/list/?tag=news_finance&ac=wap&count=20&format=json_raw&as=A145E9025A6C78B&cp=592ACC87687B1E1&max_behot_time=0",
        "http://m.toutiao.com/list/?tag=news_fashion&ac=wap&count=20&format=json_raw&as=A1353902AA9C7F9&cp=592ADCD7CF89AE1&max_behot_time=0",
    ];
    for tag_type in 0..tag_names.len() {
        if tag_names[tag_type].ne(tag.as_str()) {
            continue;
        }
        let mut res = reqwest::Client::new()
            .get(tag_urls[tag_type])
            .header(COOKIE, "tt_webid=6770693283330065934; _ga=GA1.2.97573938.1576478910")
            .header(USER_AGENT, "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36")
            .send()?;
        let raw = res.text()?;
        //        let mut file = std::fs::File::open("data/toutiao.json")?;
        //        let mut raw = String::new();
        //        file.read_to_string(&mut raw);
        #[derive(Deserialize)]
        struct HttpResponse {
            pub data: Vec<SpliderNews>,
        }
        let body: HttpResponse = serde_json::from_str(raw.as_str())?;
        let list = body.data;
        //let mut fake_img_list = extra_images(list.len())?;
        let mut news_list = vec![];
        for i in 0..list.len() {
            let sn = &list[i];
            let image_list: Vec<String> = sn.image_list.iter().map(|i| i.url.clone()).collect();
            let cur = chrono::Utc::now().naive_utc();
            news_list.push(NewsModel {
                news_id: sn.item_id.clone(),
                news_tag: tag.clone(),
                news_title: sn.title.clone(),
                news_image_urls: image_list,
                news_create_time: cur.clone(),
                news_craw_time: cur,
            })
        }
        return Ok(news_list);
    }
    Err(Box::new(StrError("not found such tab")))
}

pub fn craw_news_detail_splider(item_id: String) -> Result<NewsDetailModel, Box<dyn Error>> {
    dotenv().ok();
    let url = format!("http://m.toutiao.com/i{}/info/", item_id);
    println!("will request for {:?}", url.as_str());
    let mut res = reqwest::Client::new()
        .get(url.as_str())
        .header(USER_AGENT, "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36")
        .send()?;
    let raw = res.text()?;

    #[derive(Deserialize)]
    struct DetailResponse {
        pub title: String,
        pub content: String,
    }
    #[derive(Deserialize)]
    struct HttpResponse {
        pub data: DetailResponse,
    }
    let body: HttpResponse = serde_json::from_str(raw.as_str())?;
    //println!("detail: {}, content: {:?}", item_id, body.data.content);
    Ok(NewsDetailModel {
        title: body.data.title,
        content: body.data.content,
    })
}

pub fn crawl_news() -> Result<(), Box<dyn Error>> {
    //TODO: take apart crawling & web
    Ok(())
}
