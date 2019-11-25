## 多线程与本地存储

###  开发环境

* Mac OS
* Objective-C
* Xcode



### 基于NSOperation的多线程操作

NSOperation、NSOperationQueue 是苹果提供的一套多线程解决方案，是基于 GCD 更高一层的封装。比 GCD 更简单易用、代码可读性也更高。

NSOperation 需要与 NSOperationQueue 一起使用来实现多线程，步骤分为三步：

- 先将需要执行的操作封装到一个 NSOperation 对象中
- 创建 NSOperationQueue 对象
- 将 NSOperation 对象添加到 NSOperationQueue 对象中

之后系统会自动将 NSOperationQueue 中的 NSOperation 取出来，在新线程中执行操作。

#### 创建NSOperation

NSOperation对象有三种创建方式：

1. 创建`NSInvocationOperation`子类：

```objective-c
NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImg) object:nil];
```

2. 创建`NSBlockOperation`子类：

```objective-c
NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
		// ......
}];
```

3. 自定义`NSOperation`的子类

#### 创建NSOperationQueue

NSOperationQueue 一共有两种队列：主队列、自定义队列。添加到主队列中的操作，都会放到主线程中执行。添加到自定义队列中的操作，就会自动放到子线程中执行。

```objective-c
// 获取主队列
NSOperationQueue *queue = [NSOperationQueue mainQueue];
// 创建自定义队列
NSOperationQueue *queue = [[NSOperationQueue alloc] init];
```

#### 加入队列

```objective-c
- (void)addOperation:(NSOperation *)op;
```



### 基于GCD的多线程操作

GCD中也有任务和队列的概念。

任务包括同步执行和异步执行两种。队列则包括串行队列和并发队列。

GCD的使用步骤分两步：

- 创建一个队列
- 将任务追加到队列中

#### 创建队列

```objective-c
// 创建串行队列
dispatch_queue_t queue = dispatch_queue_create("tag", DISPATCH_QUEUE_SERIAL);
// 创建并发队列
dispatch_queue_t queue = dispatch_queue_create("tag", DISPATCH_QUEUE_CONCURRENT);
// 获取主队列
dispatch_queue_t queue = dispatch_get_main_queue()
// 获取全局并发队列
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
```

#### 创建任务

```objective-c
// 创建同步执行任务
dispatch_sync(queue, ^{
		// ......
});
// 创建异步执行任务
dispatch_async(queue, ^{
    // ......
});
```



### 沙盒机制与文件读写

#### 沙盒目录结构

- Documents：用于存储用户数据，会被iTunes备份。
- Library
  - Caches ：存放需要缓存的文件
  - Preferences ：APP偏好设置，可以通过NSUserDefaults进行读写
- tmp：用于存放临时文件，即APP退出后不再需要的文件。

#### 获取Cache路径

```objective-c
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
NSString *cachePath = [paths objectAtIndex:0];
```

#### 文件操作

```objective-c
NSFileManager *fileManager = [NSFileManager defaultManager];
NSString *filePath = [cachePath stringByAppendingPathComponent:self.fileName];
// 判断文件是否存在
[fileManager fileExistsAtPath:filePath];
// 判断文件是否存在以及判断是否是一个目录
[fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
// 遍历文件夹
[fileManager contentsOfDirectoryAtPath:filePath error:&error];
// 创建文件
[fileManager createFileAtPath:filePath contents:nil attributes:nil];
// 删除文件
[fileManager removeItemAtPath:filePath error:nil];
// 读取文件
NSData *data = [NSData dataWithContentsOfFile:filePath];
// 写入文件
[data writeToFile:filePath atomically:YES];
```

```objective-c
// 读写图片
[UIImagePNGRepresentation(img) writeToFile:filePath atomically:YES]
[UIImage imageWithContentsOfFile:filePath];
```



