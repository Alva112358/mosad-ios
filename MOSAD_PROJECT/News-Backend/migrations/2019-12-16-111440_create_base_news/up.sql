-- Your SQL goes here

CREATE TABLE t_news (
  news_id TEXT PRIMARY KEY,
  news_tag TEXT NOT NULL,
  news_title TEXT NOT NULL,
  news_image_urls TEXT[] NOT NULL,
  news_create_time TIMESTAMP NOT NULL,
  news_craw_time TIMESTAMP NOT NULL
);

INSERT INTO t_news (news_id, news_tag, news_title, news_image_urls, news_create_time, news_craw_time)
  VALUES ('12345431', '推荐', '两仪式厨上线',
  '{"https://img.moegirl.org/common/thumb/7/7e/215%E6%BB%A1%E7%A0%B4.png/250px-215%E6%BB%A1%E7%A0%B4.png"}',
  '2019-12-16 19:51:25-00', '2018-1-1 12:12:12-00');