//
//  MyTabBarController.m
//  16340129梁俊华
//
//  Created by 梁俊华 on 2019/9/28.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyTabBarController.h"
#import "LanguageListController.h"
#import "ArchiveController.h"

@interface MyTabBarController() <UITabBarControllerDelegate> {
    UINavigationController * _nav;
    UITabBarController * _tbc;
}

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupChildrenController];
    [self setTitle:[@"学习" stringByAppendingString:_name]];
}

- (void)setupChildrenController {
    
    _tbc = [[UITabBarController alloc] init];
    _tbc.delegate = self;
    _tbc.selectedIndex = 0;
    
    // 学习控制器
    LanguageListController * lc = [[LanguageListController alloc] init];
    lc.name = _name;
    lc.tabBarItem.title = @"学习";
    lc.tabBarItem.image = [UIImage imageNamed:@"learn1.png"];
    lc.tabBarItem.selectedImage = [UIImage imageNamed:@"learn2.png"];
    
    // 消息控制器
    ArchiveController * ac = [[ArchiveController alloc] initWithNav:self.navigationController];
    ac.tabBarItem.title = @"用户";
    ac.tabBarItem.image = [UIImage imageNamed:@"user1.png"];
    ac.tabBarItem.selectedImage = [UIImage imageNamed:@"user2.png"];
    _tbc.viewControllers = @[lc, ac];
    
    [self.view addSubview:_tbc.view];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex == 0) {
        [self setTitle:[@"学习" stringByAppendingString:_name]];
    } else {
        [self setTitle:@"个人档案"];
    }
}

@end
