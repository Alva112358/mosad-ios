package LoginPage

import (
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)

func QuitLogin(c *gin.Context) {
	// quit function is available only after you login in.
	session := sessions.Default(c)
	userSession := session.Get("LOGIN")

	if userSession == "" {
		c.JSON(200, gin.H {
			"state": "Error",
			"error_message": "No account is in login state",
		})
		return
	}

	session.Set("LOGIN", "")
	session.Save()
	c.JSON(200, gin.H {
		"state": "success",
	})
}