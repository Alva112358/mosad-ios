//
//  TabCollectionViewController.h
//  News
//
//  Created by tplish on 2019/12/17.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef TabCollectionViewController_h
#define TabCollectionViewController_h

#import <UIKit/UIKit.h>

typedef void(^ContentSwitchBlock)(NSInteger index);

@interface TabCollectionViewController : UICollectionViewController

- (void)updateIndex:(NSInteger)index;
- (void) configArray:(NSMutableArray<NSString *> *)tabs TabWeight:(CGFloat)weight TabHeight:(CGFloat)height Index:(NSInteger)index Block:(ContentSwitchBlock)contentSwitch;

@end

#endif /* TabCollectionViewController_h */
