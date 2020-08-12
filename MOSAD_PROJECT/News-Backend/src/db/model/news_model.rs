use crate::schema::*;
use chrono::NaiveDateTime;
use diesel::prelude::*;

#[derive(Debug, Queryable, Insertable, Identifiable, Associations, AsChangeset)]
#[primary_key(news_id)]
#[table_name = "t_news"]
pub struct NewsModel {
    pub news_id: String,
    pub news_tag: String,
    pub news_title: String,
    pub news_image_urls: Vec<String>,
    pub news_create_time: NaiveDateTime,
    pub news_craw_time: NaiveDateTime,
}

impl NewsModel {
    pub fn save(&self, conn: &PgConnection) {
        diesel::insert_into(t_news::table)
            .values(self)
            .execute(conn)
            .unwrap_or(0);
    }
    pub fn clean_old(tag: String, conn: &PgConnection) {
        //TODO: clean old news
        let cnt: i64 = t_news::table
            .filter(t_news::news_tag.eq(tag.clone()))
            .count()
            .get_result(conn)
            .expect("count error");
        println!("before clean old news, there are {} ones", cnt);
        if cnt > 40 {
            let del_list: Vec<String> = t_news::table
                .select(t_news::news_id)
                .filter(t_news::news_tag.eq(tag))
                .order(t_news::news_craw_time.asc())
                .limit((cnt - 40) as i64)
                .get_results(conn)
                .unwrap();
            let mut del_cnt = 0;
            del_list.iter().for_each(|i| {
                del_cnt += diesel::delete(t_news::table.find(i.clone()))
                    .execute(conn)
                    .expect("delete error");
            });
            println!("have deleted {} news", del_cnt);
        }
    }
    pub fn find_latest_crawl_time(tag: String, conn: &PgConnection) -> Option<NaiveDateTime> {
        t_news::table
            .select(t_news::news_craw_time)
            .filter(t_news::news_tag.eq(tag))
            .order(t_news::news_craw_time.desc())
            .first::<NaiveDateTime>(conn)
            .ok()
    }
    pub fn find_some_by_tag(tag: String, count: usize, conn: &PgConnection) -> Vec<Self> {
        //println!("trying to find by tag: {:?}", tag.clone());
        t_news::table
            .filter(t_news::news_tag.eq(tag))
            .limit(count as i64)
            .get_results(conn)
            .expect("Error find news")
    }

    pub fn search_some(text: String, count: usize, conn: &PgConnection) -> Vec<Self> {
        t_news::table
            .filter(t_news::news_title.like(format!("%{}%", text.as_str()).as_str()))
            .limit(count as i64)
            .get_results(conn)
            .expect("Error search")
    }
}
