package db

import (
	"HW7/dal/model"
	"errors"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
)

func GetArticles(offset, pageSize int) ([]*model.Article, error) {
	db, err := gorm.Open("mysql", "visitor:Visitor123@tcp(rm-wz9evf905zc36q4e7fo.mysql.rds.aliyuncs.com:3306)/news")
	if err != nil {
		return nil, errors.New("connect to database failed.")
	}
	defer db.Close()

	stream := make([]*model.Stream, 0)
	// 使用gorm api访问数据库，获取文章信息流
	db.Select("article_id, rank_1_score").Order("rank_1_score asc").Offset(offset).Limit(pageSize).Find(&stream)

	// 可能获取到的数据不足10条
	if len(stream) < pageSize {
		pageSize = len(stream)
	}

	// 组合文章id列表，准备获取文章信息
	articleIdList := make([]int64, pageSize)
	for _, item := range stream {
		articleIdList = append(articleIdList, int64(item.ArticleId))
	}

	m := make(map[int64]*model.Article)
	articleList := make([]*model.Article, 0)
	// 获取文章信息
	db.Where("article_id in (?)", articleIdList).Find(&articleList)
	for _, item := range articleList {
		// 为了后面将文章信息填充进信息流
		m[item.ArticleId] = item
	}
	return articleList, nil
}
