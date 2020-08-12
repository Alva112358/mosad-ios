-- Your SQL goes here

CREATE TABLE t_user (
  user_id SERIAL PRIMARY KEY,
  user_name TEXT NOT NULL,
  user_password TEXT NOT NULL
);

ALTER SEQUENCE t_user_user_id_seq RESTART WITH 1;