# MOSAD第二次作业实验报告

| 姓名   | 学号     | 学院                 |
| ------ | -------- | -------------------- |
| 梁俊华 | 16340129 | 数据科学与计算机学院 |

## 作业要求

给定三个用户张三，李四，王五。

给定四种语言英语、日语、德语、西班牙语。

实现场景输出（log形式即可）：随机选择一个用户和一种语言学习，从**当前日期**开始，随机产生时间进行学习，输出学习进度直至学习完毕。每个语言共8个tour，每个tour共4个unit，每次学习一个unit。

要求：

- 随机选定人名、语言后，一次性输出所有的结果。
- 随机时间指的是每次随机1-5天，每次学习时间在前一次的基础上加上刚刚随机出的天数。
- 需要用到多态。

## 关键代码与解释

1. **给定三个用户张三、李四、王五**

``` objective-c
NSArray * Person = @[@"张三", @"李四", @"王五"];
```

2. **给定四种语言英语、日语、德语、西班牙语**

``` objective-c
Language * english  = [[English alloc] init];
Language * spanish  = [[Spanish alloc] init];
Language * japanese = [[Japanese alloc] init];
Language * german   = [[German alloc] init];
NSArray * languages = @[english, spanish, japanese, german];
```

在上述代码中定义各种语言的事例时，就用到多态的动态绑定，用基类指针指向子类指针，实现多态，在具体调用**getName**方法的时候，就会输出相应语言的名字。

3. **随机选定人名、语言**

``` objective-c
// choose a person and a language.
int person_number = arc4random() % 3;
int language_number = arc4random() % 4;
NSString * person = [Person objectAtIndex:person_number];
Language * language = [languages objectAtIndex:language_number];
```

随机选定人名、语言用随机数来产生，对于三个用户，生成0-2之间的数来进行选择，对于四种语言，生成0-3之间的整数来进行选择，然后再通过Index来选定person和language。

4. **随机选定1-5日**

随机选定日期间隔也是产生1-5之间的随机整数，然后加到今天的日期里面来，更新新的学习日期。我自己采用的方法是积累日期，然后每次输出都加到最原始的日期，代码如下所示：

``` objective-c
// Define the format of date.
NSDateFormatter * df = [[NSDateFormatter alloc] init];
[df setDateFormat:@"yyyy年MM月dd日"];
NSTimeInterval oneDay = 24*60*60*1;
        
// Learning.
NSUInteger dayAfter = 0;
while (![language isFinish]) {
    NSDate * newDay = [NSDate dateWithTimeIntervalSinceNow:oneDay*dayAfter];
    [language learnOneUnit];
    NSLog(@"%@ %@ 学习%@ tour %ld unit %ld", person, [df stringFromDate:newDay], [language getName], [language getTour], [language getUnit]);
    int interval = arc4random() % 5 + 1;
    dayAfter += interval;
}
```

在上面的代码中，NSDateFormatter用来限定日期的格式，NSTimeInterval用来限定时间间隔，也就是一天，然后定义一个变量用于记录已经学习的时常，以后每次更新都进行输出。

5. **Language类实现**

Language类是所有语言的基类，它要实现的方法如下：

``` objective-c
// 作业要求实现的函数
- (void)learnOneUnit;
- (NSInteger)getTour;
- (NSInteger)getUnit;
- (bool)isFinish;
- (NSString *)getName;
```

此外为了初始化，还要实现一个构造函数，初始化**tour**和**unit**的值，函数的声明如下所示：

```  objective-c
- (id)init;
```

上面的函数都声明在**Language.h**文件中，然后我在**Language.m**文中实现上面的函数，首先实现基类的函数，如下所示：

``` objective-c
@implementation Language

// 构造函数，初始化 progress_tour 和 progress_unit 的值
- (id)init {
    self = [super init];
    progress_tour = 1;
    progress_unit = 0;
    return self;
}

// 学习一个unit的动作，如果学完4个unit，则学完一个tour.
- (void)learnOneUnit {
    if (progress_unit == 4) {
        progress_unit = 1;
        progress_tour += 1;
    } else {
        progress_unit += 1;
    }
}

// 获取当前的Tour
- (NSInteger)getTour {
    return progress_tour;
}

// 获取当前的Unit
- (NSInteger)getUnit {
    return progress_unit;
}

// 判断是否完成课程
- (bool)isFinish {
    if (progress_tour == 8 && progress_unit == 4) {
        return true;
    } else {
        return false;
    }
}

// 基类方法，子类自称后实现
- (NSString *)getName {
    return @"Language";
}

@end
```

然后是实现子类对象的方法，子类只需要重载**getName**方法即可，以English为例，如下所示：

``` objective-c
// 实现返回“英语”
@implementation English
- (NSString *)getName {
    return @"英语";
}
@end
```

## 运行结果

![image-20190907190834125](/Users/liangjunhua/Desktop/IOSHomework/MOSAD_HW2/report/img/img1.png)

## 学习收获

本次作业是第一次写Objective-C的程序，总的来说是熟悉了Objective-C的基本语法，如循环、数组、字符串等，还有在其它程序设计语言中常用到的随机数和面向对象的基本知识，相当于是入门了IOS了吧。总体来说，Objective-C的语法和其它熟悉的语言还是有不少区别的，特别是中括号的使用也是比较奇怪，还是要慢慢地熟悉吧。