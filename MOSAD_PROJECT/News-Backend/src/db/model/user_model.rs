use crate::schema::*;
use diesel::prelude::*;
use diesel::{PgConnection, RunQueryDsl};

#[derive(Debug, Clone, Queryable, Insertable)]
#[table_name = "t_user"]
pub struct UserModel {
    pub user_id: i32,
    pub user_name: String,
    pub user_password: String,
}

impl UserModel {
    pub fn create(username: String, password: String, conn: &PgConnection) {
        diesel::insert_into(t_user::table)
            .values((
                t_user::user_name.eq(username),
                t_user::user_password.eq(password),
            ))
            .execute(conn)
            .expect("Error on add user");
    }

    pub fn auth(username: String, password: String, conn: &PgConnection) -> Option<Self> {
        let users: Vec<Self> = t_user::table
            .filter(t_user::user_name.eq(username.clone()))
            .filter(t_user::user_password.eq(password.clone()))
            .load(conn)
            .expect("Error auth user");
        if users.len() > 0 {
            Some(users[0].clone())
        } else {
            None
        }
    }

    pub fn find_by_name(username: String, conn: &PgConnection) -> Option<Self> {
        let users: Vec<Self> = t_user::table
            .filter(t_user::user_name.eq(username.clone()))
            .load(conn)
            .expect("Error auth user");
        if users.len() > 0 {
            Some(users[0].clone())
        } else {
            None
        }
    }
}
