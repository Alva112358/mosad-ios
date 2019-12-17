package model

type Stream struct {
	ArticleId int64 `gorm:"column:article_id"`
	Rank1Score int64 `gorm:"column:rank_1_score"`
	Rank2Score int64 `gorm:"column:rank_2_score"`
	Rank3Score int64 `gorm:"column:rank_3_score"`
}

func (Stream) TableName() string {
	return "stream"
}
