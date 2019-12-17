package main

import "github.com/gin-gonic/gin"
import "github.com/gin-contrib/sessions"
import "github.com/gin-contrib/sessions/cookie"

func InitRouter() *gin.Engine {
	router := gin.Default()
	store := cookie.NewStore([]byte("secret"))
	router.Use(sessions.Sessions("mysession", store))
	router.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})
	return router
}