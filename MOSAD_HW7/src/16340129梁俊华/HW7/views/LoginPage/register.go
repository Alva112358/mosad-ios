package LoginPage

import (
	"HW7/dal/model"
	"fmt"
	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
)

func RegistUser(c *gin.Context) {
	// 1. Open database
	db, err := gorm.Open("mysql", "root:Cos-112358@(127.0.0.1:3306)/sysu")
	if err != nil {
		// to process error
		fmt.Println("Connect to database fail, error = %v", err)
		c.JSON(200, gin.H {
			"states": "error",
			"error_message": "Cannot bind json",
		})
		return
	}
	defer db.Close()


	// 2. Check whether the user is existed.
	var requestInfo model.User
	err = c.BindJSON(&requestInfo)
	if err != nil {
		// to process error
		fmt.Println("Cannot bind json, error = %v", err)
		c.JSON(200, gin.H {
			"states": "error",
			"error_message": "Cannot bind json",
		})
		return
	}

	// If the user is in the database, fail.
	var userQuery model.User
	err = db.Where("user_name = ?", requestInfo.UserName).First(&userQuery).Error
	if err == nil {
		fmt.Println("query fail, error = %v", err)
		c.JSON(200, gin.H {
			"states": "error",
			"error_message": "user exist",
		})
		return
	}

	// Success, insert the info into the database.
	newUser := &model.User{
		UserName:    requestInfo.UserName,
		UserPassage: requestInfo.UserPassage,
	}
	if err := db.Create(newUser).Error; err != nil {
		fmt.Println("insert fail, error = %v", err)
		c.JSON(200, gin.H {
			"states": "error",
			"error_message": "insert fail",
		})
		return
	}

	// 3. Return status.
	c.JSON(200, gin.H {
		"states": "success",
	})
}
