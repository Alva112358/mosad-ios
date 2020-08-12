//
//  ThemeManager.m
//  News
//
//  Created by tplish on 2019/12/20.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeManager.h"

// #define RGBACOLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ThemeManager()

@end

@implementation ThemeManager

static ThemeManager * instance;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[ThemeManager alloc] init];
        }
    });
    return instance;
}



- (void)setTheme:(NSString *)theme{
    if ([theme  isEqual: @"pink"]){
        self.backgroundColor = UIColor.systemPinkColor;
        self.shadowColor = UIColorFromRGB(0xFBBC90);
        self.fontColor = UIColor.systemPinkColor;
    }
}


- (UIColor *)backgroundColor{
    if (_backgroundColor == nil){
        _backgroundColor = UIColor.blackColor;
    }
    return _backgroundColor;
}

- (UIColor *)shadowColor{
    if (_shadowColor == nil){
        _shadowColor = UIColor.blackColor;
    }
    return _shadowColor;
}

- (UIColor *)fontColor{
    if (_fontColor == nil){
        _fontColor = UIColor.blackColor;
    }
    return _fontColor;
}

@end
