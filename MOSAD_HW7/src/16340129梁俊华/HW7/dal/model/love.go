package model

type Love struct {
	ArticleId int64
	UserName string
	Islike int
}

func (Love) TableName() string {
	return "love"
}
