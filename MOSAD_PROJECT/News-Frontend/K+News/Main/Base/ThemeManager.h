//
//  ThemeManager.h
//  News
//
//  Created by tplish on 2019/12/20.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef ThemeManager_h
#define ThemeManager_h

#import <UIKit/UIKit.h>

@interface ThemeManager : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, strong) UIColor * backgroundColor;
@property (nonatomic, strong) UIColor * shadowColor;
@property (nonatomic, strong) UIColor * fontColor;

- (void)setTheme:(NSString *)theme;

@end

#endif /* ThemeManagThemeManager */
