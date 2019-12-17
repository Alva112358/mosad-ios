package model

type ArtId struct {
	ArticleId int64
}

type Artnum struct {
	ArticleId int64
	LikeCount int64
}

func (Artnum) TableName() string {
	return "artnum"
}
