package LoginPage

import (
	"HW7/dal/model"
	"encoding/gob"
	"fmt"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
)

func Login(c *gin.Context) {
	gob.Register(model.User{})

	// 1. Open database
	db, err := gorm.Open("mysql", "root:Cos-112358@(127.0.0.1:3306)/sysu")
	if err != nil {
		// to process error
		fmt.Println("Connect to database fail, error = ", err)
		return
	}
	defer db.Close()


	// 2. Check whether the user is existed.
	var requestInfo model.User
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

	// If the user is in the database, fail.
	var userQuery model.User
	err = db.Where("user_name = ?", requestInfo.UserName).First(&userQuery).Error
	fmt.Println(requestInfo.UserName)
	// No return result.
	if err != nil {
		fmt.Println("query fail, error = ", err)
		c.JSON(200, gin.H {
			"state": "error",
			"error_message": "user not exist",
		})
		return
	}

	// Check whether the answer is right.
	if userQuery.UserPassage != requestInfo.UserPassage {
		c.JSON(200, gin.H {
			"state": "error",
			"error_message": "incorrect password",
		})
		return
	}

	// Check session.
	session := sessions.Default(c)
	userSession := session.Get("LOGIN")
	// You already login in with other account.
	if userSession != "" {
		c.JSON(200, gin.H {
			"message": "error",
			"error_message": "user already login in",
		})
		return
	}

	session.Set("LOGIN", requestInfo.UserName)
	session.Save()

	// Success
	c.JSON(200, gin.H {
		"message": "success",
	})
}
