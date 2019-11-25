//
//  MainController.m
//  MOSAD_HW6
//
//  Created by 梁俊华 on 2019/11/17.
//  Copyright © 2019 梁俊华. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Foundation/Foundation.h>
#import "MainController.h"
#import "ImageController.h"
#import "Masonry.h"

@interface MainController() <UITabBarControllerDelegate> {
    ImageController * imgcv;
    UITabBarController * _tbc;
    UIView * buttomView;
}

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.title = @"Pictures";
    
    imgcv = [[ImageController alloc] init];
    // [imgcv download];
    
    _tbc = [[UITabBarController alloc] init];
    _tbc.delegate = self;
    _tbc.selectedIndex = 0;

    UIButton * _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.2 - 50, 835, 100, 35)];
    _btn1.backgroundColor = [UIColor colorWithRed:102 / 255.0 green:199 / 255.0 blue:90 / 255.0 alpha:1];
    _btn1.layer.borderWidth = 1;
    _btn1.layer.cornerRadius = 7.0f;
    _btn1.layer.masksToBounds = YES;
    _btn1.layer.borderColor = (__bridge CGColorRef _Nullable)(UIColor.whiteColor);
    [_btn1 setTitle:@"加载" forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];

    UIButton * _btn2 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, 835, 100, 35)];
    _btn2.backgroundColor = [UIColor colorWithRed:102 / 255.0 green:199 / 255.0 blue:90 / 255.0 alpha:1];
    _btn2.layer.borderWidth = 1;
    _btn2.layer.cornerRadius = 7.0f;
    _btn2.layer.masksToBounds = YES;
    _btn2.layer.borderColor = (__bridge CGColorRef _Nullable)(UIColor.whiteColor);
    [_btn2 setTitle:@"清空" forState:UIControlStateNormal];
    [_btn2 addTarget:self action:@selector(clean) forControlEvents:UIControlEventTouchUpInside];

    UIButton * _btn3 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.8 - 50, 835, 100, 35)];
    _btn3.backgroundColor = [UIColor colorWithRed:102 / 255.0 green:199 / 255.0 blue:90 / 255.0 alpha:1];
    _btn3.layer.borderWidth = 1;
    _btn3.layer.cornerRadius = 7.0f;
    _btn3.layer.masksToBounds = YES;
    _btn3.layer.borderColor = (__bridge CGColorRef _Nullable)(UIColor.whiteColor);
    [_btn3 setTitle:@"删除缓存" forState:UIControlStateNormal];
    [_btn3 addTarget:self action:@selector(deleteCache) forControlEvents:UIControlEventTouchUpInside];

    [_tbc.view addSubview:_btn1];
    [_tbc.view addSubview:_btn2];
    [_tbc.view addSubview:_btn3];
     _tbc.viewControllers = @[imgcv];
    [self.view addSubview:_tbc.view];
}

//- (void)setLayout {
//    UIView * superview = self.view;
//
//    [buttomView makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(superview.bottom);
//    }];
//}

- (void)download {
    [imgcv download];
}

- (void)clean {
    [imgcv clean];
}

- (void)deleteCache {
    [imgcv deleteCache];
}

@end
