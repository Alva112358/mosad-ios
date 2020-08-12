# REST API DOC [ /api/v1 ]

**Global Base URL** ```http://localhost:8000/api/v1```

在运行 curl 例子前请在shell环境中设置变量`$BASE_URL`，例如:
```shell
export BASE_URL=localhost:8000/api/v1
```

或者人眼替换`$BASE_URL`

## 应用首页 [ /base ]

---

### 获取Tab标签名

**GET** ```/news/tabs```

#### Response

```
{
  "code": 200,
  "data": {
    "len": number,
    "names": string[],
  },
}
```

#### Sample
```shell
curl -XGET "$BASE_URL/news/tabs"
```
---

### 获取若干新闻预览信息

**GET** ```/news/<tabIndex>/entry?<count>```

+ count - 请求至多几条新闻标题。返回数量可能不足`count`。

#### Response

```
{
  "code": 200,
  "data": {
    “data”: {
      “id”: string,
      "title": string,
      "image_links": string[],
      "detail_url": string,
    }[],
  },
}
```

#### Sample

```shell
curl -XGET "$BASE_URL/news/1/entries?count=3&img_most=3"
```

### 获取新闻详情页数据

**GET** ```/news/details/<newsIndex>```

+ newsIndex - 使用上一条请求返回的`data.data.id`字段

#### Response

```
{
  "code": 200,
  "data": {
    "title": string,
    "body": string,
  }
}
```

+ 当 `data.type = "typography"`时，`data.content`为原始内容字符串
+ 当 `data.type = "image"` 时，`data.content`为图片URL
+ 评论显示更多就请求`more_url`字段值（还没做

#### Sample

```shell
curl -XGET "$BASE_URL/news/details/1"
```

## 图片页 [ /photo ]

### 获取图片预览信息

**GET** ```/photo/entries?<count>```

#### Response

```
{
  "code": 200,
  "data": {
    "count": number,
    "data": {
      "image_link": string,
    }[],
  }[],
}
```

#### Sample

```shell
curl -XGET "$BASE_URL/photo/entries?count=5"
```

## 视频页 [ /video ]

### 获取视频预览信息

**GET** ```/video/entries?<count>```

#### Response

```
{
  "code": 200,
  "data": {
    "count": number,
    "data": {
      "id": number,
      "title": string,
      "uploader": string,
      "video_preview": string,
      "video_link": string,
      "n_good": number,
      "n_comment": number,
    }[],
  }
}
```

+ `video_preview` - 浏览图图片地址

#### Sample

```shell
curl -XGET "$BASE_URL/video/entries?count=5"
```

## 用户页 

### 注册

**POST** ```/users```

| Name | Type |
| --- | --- |
| username | string |
| password | string |

#### Response

成功后会自动登录，返回token

```
{
  "code": 200,
  "data": {
    "token": string,
    "success": true,
  },
}
```

失败返回错误信息

```
{
  "code": 500 | 400,
  "data": {
    "message": string,
  },
}
```

#### Sample

```shell
curl -XPOST -H "Content-Type: application/json" -d '{"username": "1", "password":"1"}' "$BASE_URL/users"
```

### 登录

**POST** ```/login```

| Name | Type |
| --- | --- |
| username | string |
| password | string |

#### Response

成功后会自动登录，返回token

```
{
  "code": 200,
  "data": {
    "token": string,
  },
}
```

```
{
  "code": 500 | 400,
  "data": {
    "message": string,
  },
}
```

#### Sample

```shell
curl -XPOST -H "Content-Type: application/json" -d '{"username": "1", "password":"1"}' "${BASE_URL}/login"
```

## 搜索

### 搜索栏输入文字查询

**GET** ```/search?<text>&<count>```

+ text: 查询文字
+ count: 最多接受多少个查询结果

#### Response

```
{
  "code": 200,
  "data": {
    "result": []{
      "title": string,
      "tag": string,
      "detail_url": string,
    }
  }
}
```

#### Sample

```shell
curl -XGET "${BASE_URL}/search?text=\"华为\"&count=3"
```