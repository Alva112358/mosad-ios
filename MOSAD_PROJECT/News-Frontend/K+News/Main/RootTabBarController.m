//
//  RootTabBarController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootTabBarController.h"

#import "NavigationController.h"
#import "NewsPage/Controller/HomeViewController.h"
#import "VideoPage/Controller/VideoViewController.h"
#import "PhotoPage/Controller/PhotoViewController.h"


@interface RootTabBarController()

@end

@implementation RootTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tabBar.tintColor = UIColor.systemPinkColor;
        
    [self addChildVC:[[HomeViewController alloc] init] Title:@"Home" Image:@"home" SelectedImage:@"home-fill"];
    
    [self addChildVC:[[VideoViewController alloc] init] Title:@"Video" Image:@"video" SelectedImage:@"video-fill"];
    
    [self addChildVC:[[PhotoViewController alloc] init] Title:@"Photo" Image:@"pic" SelectedImage:@"pic-fill"];
}


- (void)addChildVC:(UIViewController*)childVC
             Title:(NSString*)title
             Image:(NSString*)image
     SelectedImage:(NSString*)selectedImage{
    childVC.title = title;
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    NavigationController * nav = [[NavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

@end
