package UserInteraction

import (
	"HW7/dal/model"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	_ "github.com/go-sql-driver/mysql"
	"strconv"
)

// Get count according to the article_id
func GetCount(c *gin.Context) {
	// Open my database.
	db, err := gorm.Open("mysql", "root:Cos-112358@(127.0.0.1:3306)/sysu")
	if err != nil {
		// to process error
		fmt.Println("Connect to database fail, error = ", err)
		return
	}
	defer db.Close()

	// Get article id.
	var requestInfo model.ArtId
	err = c.BindJSON(&requestInfo)
	if err != nil {
		// to process error
		fmt.Println("Cannot bind json, error = ", err)
		c.JSON(200, gin.H {
			"state": "error",
			"error_message": "Cannot bind json",
		})
		return
	}
	var articleId = requestInfo.ArticleId

	// Get the number of like.
	var count model.Artnum
	err = db.Where("article_id = ?", articleId).Find(&count).Error
	if err != nil {
		fmt.Println("Cannot bind json, error = ", err)
	}

	c.JSON(200, gin.H {
		"state": "success",
		"article_id": strconv.FormatInt(articleId, 10),
		"like_count": strconv.FormatInt(count.LikeCount, 10),
	})
}