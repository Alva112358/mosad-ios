//
//  Language.m
//  MOSAD_HW2
//
//  Created by 梁俊华 on 2019/9/2.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Language.h"

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

// 实现返回“英语”
@implementation English
- (NSString *)getName {
    return @"英语";
}
@end

// 实现返回“西班牙语”
@implementation Spanish
- (NSString *)getName {
    return @"西班牙语";
}
@end

// 实现返回"日语"
@implementation Japanese
- (NSString *)getName {
    return @"日语";
}
@end

// 实现返回"德语"
@implementation German
- (NSString *)getName {
    return @"德语";
}
@end
