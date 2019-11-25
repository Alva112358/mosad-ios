//
//  ImageController.h
//  MOSAD_HW6
//
//  Created by 梁俊华 on 2019/11/24.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#ifndef ImageController_h
#define ImageController_h
#import <UIKit/UIKit.h>

@interface ImageController : UIViewController

@property (strong, nonatomic) NSMutableArray <UIImage *> * dataSource;

- (void)download;

- (void)clean;

- (void)deleteCache;

@end

#endif /* ImageController_h */
