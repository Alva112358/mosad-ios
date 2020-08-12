//
//  ContentPageViewController.h
//  News
//
//  Created by tplish on 2019/12/17.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef ContentPageViewController_h
#define ContentPageViewController_h

#import <UIKit/UIKit.h>

typedef void(^TabSwitchBlock)(NSInteger index);

@interface ContentPageViewController : UIPageViewController

- (void) updateIndex:(NSInteger)index;
- (void) configArray:(NSMutableArray<UIViewController *> *)controllers Index:(NSInteger)index Block:(TabSwitchBlock)tabSwitch;

@end

#endif /* ContentPageViewController_h */
