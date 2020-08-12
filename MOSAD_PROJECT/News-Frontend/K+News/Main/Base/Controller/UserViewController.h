//
//  UserViewController.h
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef UserViewController_h
#define UserViewController_h

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController

@property (nonatomic, strong) NSString * token;

+ (id)shareInstance;

@end

#endif /* UserViewController_h */
