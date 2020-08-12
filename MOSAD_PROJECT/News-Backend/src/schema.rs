table! {
    t_news (news_id) {
        news_id -> Text,
        news_tag -> Text,
        news_title -> Text,
        news_image_urls -> Array<Text>,
        news_create_time -> Timestamp,
        news_craw_time -> Timestamp,
    }
}

table! {
    t_user (user_id) {
        user_id -> Int4,
        user_name -> Text,
        user_password -> Text,
    }
}

allow_tables_to_appear_in_same_query!(t_news, t_user,);
