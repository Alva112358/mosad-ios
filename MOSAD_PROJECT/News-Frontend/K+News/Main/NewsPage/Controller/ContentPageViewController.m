//
//  ContentPageViewController.m
//  News
//
//  Created by tplish on 2019/12/17.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentPageViewController.h"

@interface ContentPageViewController()
<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
{
    NSInteger currentIndex;
}
@property (nonatomic, strong) NSArray<UIViewController *> * controllers;
@property (nonatomic, strong) TabSwitchBlock tabSwitch;
@end

@implementation ContentPageViewController

- (instancetype)init{
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self){
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (void)updateIndex:(NSInteger)index{
    if (index > currentIndex){
        [self setViewControllers:@[self.controllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    } else {
        [self setViewControllers:@[self.controllers[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    currentIndex = index;
}

- (void)configArray:(NSMutableArray<UIViewController *> *)controllers Index:(NSInteger)index Block:(TabSwitchBlock)tabSwitch{
    _controllers = controllers;
    _tabSwitch = tabSwitch;
    [self updateIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == 0){
        return nil;
    }
    index --;
    
    return [self pageControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == self.controllers.count - 1){
        return nil;
    }
    index ++;
    return [self pageControllerAtIndex:index];
}

-(UIViewController*)pageControllerAtIndex:(NSInteger)index{
    return self.controllers[index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    NSInteger index = [self.controllers indexOfObject:pageViewController.viewControllers[0]];
    self.tabSwitch(index);
}

@end
