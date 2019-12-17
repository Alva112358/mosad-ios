package model

type Article struct {
	ArticleId int64 `gorm:"column:article_id" json:"article_id"`
	Title string `gorm:"column:title" json:"title"`
	Cover string `gorm:"column:cover" json:"image_url"`
	Author string `gorm:"column:author" json:"author_name"`
	Content string `gorm:"column:content" json:"content"`
	PublishTime int64 `gorm:"column:publish_time" json:"publish_time"`
}

func (Article) TableName() string {
	return "article"
}
