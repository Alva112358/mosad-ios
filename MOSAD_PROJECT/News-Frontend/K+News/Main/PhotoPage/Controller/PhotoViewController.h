//
//  PhotoViewController.h
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef PhotoViewController_h
#define PhotoViewController_h

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (strong, nonatomic) NSMutableArray<UIImage *> * dataSource;

@property (strong, nonatomic) UICollectionView * collection;

@end

#endif /* PhotoViewController_h */
