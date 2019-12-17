package model

type User struct {
	UserName    string `gorm:"column:user_name"`
	UserPassage string `gorm:"column:user_passage"`
}

func (User) TableName() string {
	return "users"
}
