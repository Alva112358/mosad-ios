# 中山大学数据科学与计算机学院本科生实验报告
| 课程名称 | 现代操作系统应用开发 |   任课老师   |           郑贵锋            |
| :------: | :------------------: | :----------: | :-------------------------: |
|   年级   |        2016级        | 专业（方向） | 软件工程（计算机应用软件）  |
|   学号   |       16340129       |     姓名     |           梁俊华            |
|   电话   |     13902878689      |    Email     | liangjh45@mail2.sysu.edu.cn |
| 开始日期 |    2019年12月15日    |   完成日期   |       2019年12月17日        |



## 一、实验题目

个人作业7 - 基于Go语言的服务端接口开发



## 二、实现内容

首先，根据课堂教学PPT的内容，完成服务端开发环境搭建。

然后使用Go语言完成服务端接口开发，具体业务需求如下：

初始页面是应用启动后显示的第一个页面，可以上下滑动查看feed流。

1. 设计服务端接口协议，完善信息流接口
   - 参考课堂提到的样例代码，独立完成feed流内容接口的定义和开发
2. 设计服务端接口协议及数据库表设计，支持用户注册登录功能
   - 完善App页面右下角的“个人中心”，支持输入用户名+密码完成注册、登录的功能
   - 支持用户退出登录
3. 设计服务端接口协议及数据库表设计，支持点赞功能
   - 每个feed流中的文章，会显示该文章累计获得的点赞总数
   - 用户登录状态下， 每个文章会显示用户是否已经点赞过，如果点赞过，则会显示为红色实心的“心”，没有点赞过，则显示空心的“心”。
   - 用户可以对文章进行点赞和取消点赞操作。如果用户未登录，则服务端接口返回未登录，客户端页面跳转用户登录注册界面。如果用户已登录，则可以进行点赞和取消点赞。
   - 一个登录用户最多只能点赞同一文章一次，对已点赞的文章再次点赞，则相当于进行取消点赞操作。



## 三、实验结果

### 1. 设计服务端接口协议，完善信息流接口

- 参考课堂提到的样例代码，独立完成feed流内容接口的定义和开发

feed流内容的接口定义如下：

- 接口URL：/api/feed

- 请求方式：GET

- 请求参数：None

- 返回字段：

  | 字段          | 字段含义         |
  | ------------- | ---------------- |
  | error_message | 出错原因         |
  | has_more      | 是否有更多的信息 |
  | items         | 文章内容         |

- 请求样例

  直接GET请求即可，返回的样例如下所示：

  ![image-20191217202122753](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img1.png)

  相关代码与课上提供的基本相同，但是自己维护了一个表，将文章的ID和点赞总数联系在一起，方便后面的点赞功能的实现，代码如下所示：

  ``` go
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
  ```

  数据库的操作过程使用gorm框架，主要涉及到数据库的连接，增删改查，其中设计的数据库的字段如下所示：

  | 字段       | 数据类型 |
  | ---------- | -------- |
  | article_id | int64    |
  | like_count | int64    |

  实现数据库的MySQL代码如下所示：

  ``` mysql
  create table artnum (
  		article_id bigint primary key,
      like_count bigint
  );
  ```

###2. 设计服务端接口协议及数据库表设计，支持用户注册登录功能

一、注册功能的实现

首先是用户数据库表的设计，在本次实验中设计得比较简单，具体如下所示：

| 字段         | 数据类型 |
| ------------ | -------- |
| user_name    | string   |
| user_passage | string   |

创建上述数据库的MySQL代码如下所示：

``` mysql
create table artnum (
		user_name  varchar(10),
    like_count varchar(10)
);
```

**接口URL**：/api/register

**请求方法**：POST

**请求参数**：

| 请求参数    | 返回参数 |
| ----------- | -------- |
| UserName    | 用户名   |
| UserPassage | 密码     |

**返回字段**：

| 返回字段      | 含义                  |
| ------------- | --------------------- |
| states        | 状态：success ｜error |
| error_message | 错误信息              |

**请求样例**

在BODY中输入请求参数的Json格式：

![image-20191217203930294](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img2.png)

第一次注册，在表格中没有重名的，因此注册成功，在数据库中可以观察到：

![image-20191217204032380](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img3.png)

得到的返回信息如下所示：

![image-20191217204113474](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img4.png)

同时，如果再次请求，则会因为数据库中不能有重复的用户信息而注册失败，得到的返回信息如下所示：

![image-20191217204942862](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img5.png)

相关的代码：

1. 查询用户是否存在

   ``` go
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
   ```

2. 添加用户

   ``` go
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
   ```

二、登陆功能实现

登陆功能在注册的数据库的基础上实现

**接口URL**：/api/login

**请求方式**：POST

**请求参数**：

| 字段                 | 字段类型 |
| -------------------- | -------- |
| UserName 用户名      | string   |
| UserPassage 用户密码 | string   |

**返回字段**

| 返回字段      | 含义                  |
| ------------- | --------------------- |
| state         | 状态 success \| error |
| error_message | 错误信息              |

**请求样例**

只有在数据库中存在的账户才能够登陆，否则会返回错误信息

请求的方式跟注册过程一样，提交的表单都是相同的，由于我的session状态一直存在，登陆的是Alva的账号，因此会显示用户已登陆的信息，得到的返回信息如下所示：

![image-20191217210651601](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img6.png)

本部分逻辑判断的代码如下所示：

``` go
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
```

其中维持登陆状态用的是session，在登陆前会检查session的状态，如果session中"LOGIN"字段不为空，则表示已经登陆，否则可以登陆，代码如下所示：

``` go
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
```

三、退出功能

退出功能只需要对session的状态进行相应的维护即可

**接口URL**：/api/quit

**请求方式**：GET

**请求参数**：无

**返回字段**：

| 返回字段      | 字段含义               |
| ------------- | ---------------------- |
| state         | 状态：success \| error |
| error_message | 错误信息               |

**请求样例**：

在登陆后直接执行GET请求，即可退出，执行后的结果如下所示：

![image-20191217212039108](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img7.png)

若再次执行退出，则会失败，如下所示：

![image-20191217212338520](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img8.png)

相关的代码如下所示：

``` go
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
```

### 3. 设计服务端接口协议及数据库表设计，支持点赞功能

一、获取文章的赞的总数

在设计中，维护一张文章及其点赞数目的数据库表，以及一张点赞记录表，用于记录用户的点赞状态，文章及其点赞数目的数据库表在上面有提及过，二点赞记录表的字段如下所示：

| 字段       | 字段类型 |
| ---------- | -------- |
| article_id | bigint   |
| user_name  | string   |
| islike     | int      |

创建数据库的MySQL代码如下所示：

``` mysql
create table love (
		article_id 	bigint,
		user_name 	varchar(10),
    islike 			int
);
```

获取文章的点赞数目，只需要直接访问数据库中相应的字段即可，相关的代码如下所示：

``` go
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
			"message": "error",
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
		"message": "success",
		"article_id": strconv.FormatInt(articleId, 10),
		"like_count": strconv.FormatInt(count.LikeCount, 10),
	})
}
```

**接口URL**：/api/getNumber

**请求方式**：POST

**请求参数**：请求参数在前端的操作会传到后端

| 请求参数   | 参数含义 |
| ---------- | -------- |
| article_id | 文章id   |

**返回参数**：

| 返回参数      | 参数含义              |
| ------------- | --------------------- |
| state         | 状态 success \| error |
| error_message | 错误信息              |
| article_id    | 文章ID                |
| like_count    | 点赞总数              |

**请求样例**

在Postman上面进行测试，如下图所示：

![image-20191217214713096](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img9.png)

测试的结果如下所示：

![image-20191217214738789](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img10.png)

二、用户点赞

用户点赞根据用户的点赞状态来进行判断，如果数据库中不存在点赞记录，则默认添加一条点赞记录，如果有点赞记录，且处于已经点赞状态，则取消点赞，否则点赞成功。

第一次点赞，添加点赞记录到数据库中的代码如下所示：

``` go
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
    "message": "success",
    "new_message": "Yes",
  })
  return
}
```

根据点赞记录进行判断的代码如下所示：

``` go
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
```

**接口URL**：/api/click

**请求方式**：POST

**请求参数**：

| 请求参数   | 参数含义 |
| ---------- | -------- |
| article_id | 文章id   |

**返回字段**

| 返回参数    | 参数含义              |
| ----------- | --------------------- |
| state       | 状态 success \| error |
| new_message | 是否是新点赞信息      |
| message     | 成功字段              |

**请求样例**

首次点赞，在Postman上面的操作如下所示：

![image-20191217220211937](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img12.png)

若未登陆，则禁止操作，得到的信息如下所示：

![image-20191217215912686](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img11.png)

登陆后再次操作，得到的信息如下所示：

![image-20191217220535116](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img13.png)

检查数据库：

![image-20191217220601959](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img14.png)

可以发现点赞数目增加了1，再次提交，应该是取消点赞，得到的结果如下：

![image-20191217220650511](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img15.png)

检查数据库：

![image-20191217220722963](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW7/MOSAD_HW7/report/16340129梁俊华/img/img16.png)

可以发现取消了点赞

## 四、实验思考及感想

本次作业是我第一次搭建服务端，也是我第一次用go语言写应用，在0基础入门上还是显得比较困难，很多语言知识和数据库知识都需要重新复习，但是着也给我了复习旧知识的机会，所以说还是比较难得的。以前从来没写过登陆注册的功能，在以前的project中我都是写前端的，这次感觉还是有比较多的收获的。

