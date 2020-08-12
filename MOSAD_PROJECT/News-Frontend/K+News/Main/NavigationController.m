//
//  NavigationController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavigationController.h"
#import "Base/Controller/UserViewController.h"

@interface NavigationController()
@property (nonatomic, strong) UIViewController * rootVC;
@end

@implementation NavigationController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationBar.tintColor = UIColor.systemPinkColor;
}

// push页面时自动隐藏tabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // rootViewController也算push，所以需要判断数量
    if (self.viewControllers.count){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
