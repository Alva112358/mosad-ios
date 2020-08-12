use crate::db::model::video_model::VideoModel;

use rand::random;

use std::collections::HashMap;

use std::error::Error;

#[derive(Deserialize)]
struct SpliderVideo {
    mp4_url: String,
    vid: String,         // id
    videosource: String, // 作者名字
    title: String,
    cover: String, // 封面图片地址
}

pub fn craw_video_splider() -> Result<Vec<VideoModel>, Box<dyn Error>> {
    let tag_names = [
        "搞笑",
        "体育",
        "新闻现场",
        "涨姿势",
        "猎奇",
        "黑科技",
        "默认",
    ];
    let tag_patterns = [
        "VAP4BFE3U",
        "VBF8F2E94",
        "VAV3H6JSN",
        "VBF8F3SGL",
        "VBF8ET3S2",
        "VBF8F2PKF",
        "VAP4BFE3U",
    ];
    let tag_type = random::<usize>() % tag_names.len();
    let page = random::<usize>() % 40 + 1;
    let mut res = reqwest::get(
        format!(
            "http://c.m.163.com/nc/video/list/{}/y/{}-20.html",
            tag_patterns[tag_type], page
        )
        .as_str(),
    )?;
    let raw = res.text()?;
    #[derive(Deserialize)]
    struct HttpResponse {
        #[serde(flatten)]
        pub data: HashMap<String, Vec<SpliderVideo>>,
    }
    let body: HttpResponse = serde_json::from_str(raw.as_str())?;
    let list = body.data.get(tag_patterns[tag_type]).unwrap();
    let video_list: Vec<VideoModel> = list
        .iter()
        .map(|s| VideoModel {
            video_id: s.vid.clone(),
            video_link: s.mp4_url.clone(),
            video_uploader: s.videosource.clone(),
            video_title: s.title.clone(),
            video_cover_link: s.cover.clone(),
        })
        .collect();
    Ok(video_list)
}
