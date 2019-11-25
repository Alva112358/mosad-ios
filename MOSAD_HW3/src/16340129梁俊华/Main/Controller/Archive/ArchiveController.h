//
//  ArchiveController.h
//  16340129梁俊华
//
//  Created by 梁俊华 on 2019/9/28.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#ifndef ArchiveController_h
#define ArchiveController_h

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "MyTabBarController.h"
#import "Masonry.h"

@interface ArchiveController : UIViewController

- (id)initWithNav:(UINavigationController *)nav;

@property (strong, nonatomic) NSArray <NSString *> * info;

@property (strong, nonatomic) NSArray <NSString *> * setting;


@end

#endif /* ArchiveController_h */
