//
//  AppDelegate.m
//  16340129梁俊华
//
//  Created by 梁俊华 on 2019/9/25.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate () {
    UINavigationController * _nav;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)app didFinishLaunchingWithOptions: (NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    _nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    // _nav.delegate = self;
    self.window.rootViewController = _nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
