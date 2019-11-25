//
//  LanguageListController.h
//  16340129梁俊华
//
//  Created by 梁俊华 on 2019/9/28.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#ifndef LanguageListController_h
#define LanguageListController_h
#import <UIKit/UIKit.h>
#import "Masonry.h"


@interface LanguageListController : UIViewController

@property (nonatomic, strong) NSArray< NSMutableDictionary * > * dataSource;

@property (nonatomic, strong) NSString * name;

@end

#endif /* LanguageListController_h */

