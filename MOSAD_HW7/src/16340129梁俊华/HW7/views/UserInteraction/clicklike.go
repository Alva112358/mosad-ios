package UserInteraction

import (
	"HW7/dal/model"
	"fmt"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
)

// Request: article_id
func ClickLike(c *gin.Context) {
	// Check whether user is login.x
	session := sessions.Default(c)
	userSession := session.Get("LOGIN")
	//fmt.Println(userSession)
	if userSession == "" {
		c.JSON(200, gin.H {
			"message": "error",
			"Login": "No",
		})
		return
	}

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
			"message": "error",
			"error_message": "Cannot bind json",
		})
		return
	}
	var articleId = requestInfo.ArticleId

	// Check the state of the article.
	var test model.Love
	var article = model.Artnum{}
	db.Where("article_id = ? AND user_name = ?", articleId, session.Get("LOGIN").(string)).Find(&test)
	// No record before.
	fmt.Println(test.UserName)
	fmt.Println(test.ArticleId)
	if test.UserName == "" {

		db.Create(&model.Love{
			ArticleId: articleId,
			UserName:  userSession.(string),
			Islike:    1,
		})

		db.Where("article_id = ?", requestInfo.ArticleId).Find(&article)
		db.Model(&article).Where("article_id = ?", requestInfo.ArticleId).Update("like_count", article.LikeCount + 1)

		c.JSON(200, gin.H {
			"state": "success",
			"new_message": "Yes",
		})
		return
	}

	// If liked before, cancel.
	if test.Islike == 1 {
		db.Where("article_id = ?", requestInfo.ArticleId).Find(&article)
		db.Model(&article).Where("article_id = ?", requestInfo.ArticleId).Update("like_count", article.LikeCount - 1)
		db.Model(&test).Where("article_id = ? AND user_name = ?", articleId, session.Get("LOGIN").(string)).Update("islike", 0)
		// Success.
		c.JSON(200, gin.H {
			"state": "success",
			"message": "Successfully cancel your like.",
		})
	} else {
		// Not like before.
		db.Where("article_id = ?", requestInfo.ArticleId).Find(&article)
		db.Model(&article).Where("article_id = ?", requestInfo.ArticleId).Update("like_count", article.LikeCount + 1)
		db.Model(&test).Where("article_id = ? AND user_name = ?", articleId, session.Get("LOGIN").(string)).Update("islike", 1)
		// Success.
		c.JSON(200, gin.H {
			"state": "success",
			"message": "Successfully like the article.",
		})
	}
}
