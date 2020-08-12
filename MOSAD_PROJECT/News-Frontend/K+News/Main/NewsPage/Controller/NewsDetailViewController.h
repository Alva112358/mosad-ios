//
//  NewsDetailViewController.h
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef NewsDetailViewController_h
#define NewsDetailViewController_h

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController
@property (nonatomic, strong) NSString * detailUrl;
@property (nonatomic, strong) UINavigationController * curNav;
@end

#endif /* NewsDetailViewController_h */
