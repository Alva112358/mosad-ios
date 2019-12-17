package main

import (
	"HW7/views/LoginPage"
	"HW7/views/MainPage"
	"HW7/views/UserInteraction"
)

func main() {
	router := InitRouter()
	router.GET("/api/feed", MainPage.GetFeed)
	router.POST("/api/register", LoginPage.RegistUser)
	router.POST("/api/login", LoginPage.Login)
	router.POST("/api/getNumber", UserInteraction.GetCount)
	router.POST("/api/click", UserInteraction.ClickLike)
	router.GET("/api/quit", LoginPage.QuitLogin)
	router.Run(":8080")
}