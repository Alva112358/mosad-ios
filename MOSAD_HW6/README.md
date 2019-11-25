## MOSAD_HW6
### 介绍

个人作业6 - 多线程和本地存储



###  开发环境

* Mac OS
* Objective-C
* Xcode

DeadLine: 11月24日23:59 



### 任务

###  多线程与本地存储

---

### 实验目的

1. 学习使用NSOperation或GCD进行多线程操作

2. 学习iOS沙盒机制，进行文件读写操作



### 实验内容

实现一个简单的图片浏览应用，页面如下：

|            初始状态             |            加载图片             |
| :-----------------------------: | :-----------------------------: |
| ![初始状态](./manual/img/1.png) | ![加载图片](./manual/img/2.png) |

manual中有演示视频，要求如下：

1. 只有一个页面，包含一个Label，一个图片列表（可以用UICollectionView或UITableView），以及三个按钮（"加载" "清空" "删除缓存"）。
2. 点击"加载"按钮，若Cache中没有缓存的文件，则加载网络图片并显示在图片列表中，要求：
   - 在子线程下载图片，返回主线程更新UI
   - 图片下载完成前，显示loading图标
   - 图片下载后，存入沙盒的Cache中
3. 点击"加载"按钮，若Cache中已存在图片文件，则直接从Cache中读取出图片并显示。
4. 点击"清空"按钮，清空图片列表中的所有图片。
5. 点击"删除缓存"按钮，删除存储在Cache中的图片文件。



#### 图片数据

可以自行寻找5到8张网络图片，或直接使用以下URL：

```
https://hbimg.huabanimg.com/d8784bbeac692c01b36c0d4ff0e072027bb3209b106138-hwjOwX_fw658
https://hbimg.huabanimg.com/6215ba6f9b4d53d567795be94a90289c0151ce73400a7-V2tZw8_fw658
https://hbimg.huabanimg.com/834ccefee93d52a3a2694535d6aadc4bfba110cb55657-mDbhv8_fw658
https://hbimg.huabanimg.com/f3085171af2a2993a446fe9c2339f6b2b89bc45f4e79d-LacPMl_fw658
https://hbimg.huabanimg.com/e5c11e316e90656dd3164cb97de6f1840bdcc2671bdc4-vwCOou_fw658
```



### 验收内容

- 点击"加载"，正常加载网络图片，加载过程中的loading图标能正常显示
- 清空图片后，再次点击"加载"，能够正常地从Cache读取图片
- 删除缓存并清空图片后，点击"加载"，再次从网络获取图片



### 加分项

分别使用NSOperationQueue和GCD两种方式实现多线程操作。（现场验收不作检查，请在实验报告中体现）



### 提交要求及命名格式

/src 存放项目文件

/report 存放项目报告

个人项目提交方式:

- 布置的个人项目先fork到个人仓库下；
- clone自己仓库的个人项目到本地目录；
- 在个人项目中，在src、report目录下，新建个人目录，目录名为“学号+姓名”，例如“12345678WangXiaoMing”；
在“src\12345678WangXiaoMing”目录下，保存项目，按要求完成作业;
- 实验报告以md的格式，写在“report\12345678WangXiaoMing”目录下；
- 完成任务需求后，Pull Request回主项目的master分支，PR标题为“学号+姓名”， 如“12345678王小明”；
- 一定要在deadline前PR。因为批改后，PR将合并到主项目，所有同学都能看到合并的结果，所以此时是不允许再PR提交作业的。
