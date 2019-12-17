package MainPage

import (
	"HW7/dal/db"
	"HW7/dal/model"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	"strconv"
)

func GetFeed(c *gin.Context) {
	pageSizeStr := c.DefaultQuery("page_size", "10")
	pageSize, err := strconv.ParseInt(pageSizeStr, 10, 64)
	if err != nil {
		// logs.CtxError(c, "invalid page size, err=%v, page_size=%v", err, pageSizeStr)
		c.JSON(200, gin.H{
			"message": "error",
			"error_message": "invalid page size.",
		})
		return
	}
	offsetStr := c.DefaultQuery("offset", "0")
	offset, err := strconv.ParseInt(offsetStr, 10, 64)
	if err != nil {
		// logs.CtxError(c, "invalid offset, err=%v, offset=%v", err, offsetStr)
		c.JSON(200, gin.H{
			"message": "error",
			"error_message": "invalid offset.",
		})
		return
	}


	res := gin.H{
		"message":       "success",
		"error_message": "",
		"total":         pageSize,
		"has_more":      true,
	}
	items, err := db.GetArticles(int(offset), int(pageSize))
	if err != nil {
		c.JSON(200, gin.H{
			"message": "error",
			"error_message": err.Error(),
		})
		return
	}
	res["items"] = items

	// 1. Add articleId into my own database.
	db, err := gorm.Open("mysql", "root:Cos-112358@(127.0.0.1:3306)/sysu")
	if err != nil {
		// to process error
		fmt.Println("Connect to database fail, error = %v", err)
		return
	}
	defer db.Close()

	var i = 0

	for i = 0; i < len(items); i++ {
		var artId = items[i].ArticleId
		newArticle := &model.Artnum{
			ArticleId: artId,
			LikeCount: 0,
		}
		err = db.Create(newArticle).Error
		if err != nil {
			fmt.Println(err)
		}
	}


	c.JSON(200, res)
}