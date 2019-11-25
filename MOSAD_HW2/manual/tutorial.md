## 面向对象编程——多态

###  开发环境

* Mac OS
* Objective-C
* Xcode

### 多态

多态（Polymorphism），在面向对象语言中指的是同一个接口可以有多种不同的实现方式，OC中的多态则是不同对象对同一消息的不同响应方式，子类通过重写父类的方法来改变同一消息的实现，体现多态性。另外我们知道C++中的多态主要是通过virtual关键字(虚函数、抽象类等)来实现，具体来说指的是允许父类的指针指向子类对象，成为一个更泛化、容纳度更高的父类对象，这样父对象就可以根据实际是哪种子类对象来调用父类同一个接口的不同子类实现。

### 实验

现在有一个语言基类Language，其下有若干个子类，English、Japanese、German等等，父类有一个统一接口：getName，子类各自有自己的接口实现，返回各自对应语言名字的中文翻译。这里给出.h的参考实现，具体的.m文件自行补充。

```objective-c
//
//  Language.h
//  LanguageLearning
//
//  Created by 陈统盼 on 2019/8/31.
//  Copyright © 2019 TMachine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Language : NSObject {
    NSInteger progress_tour;
    NSInteger progress_unit;
}

- (void)learnOneUnit;
- (NSInteger)getTour;
- (NSInteger)getUnit;
- (bool)isFinish;
- (NSString *)getName;

@end

@interface English : Language {
    
}

@end

@interface Japanese : Language {
    
}

@end

@interface German : Language {
    
}

@end

@interface Spanish : Language {
    
}

@end

NS_ASSUME_NONNULL_END

```



