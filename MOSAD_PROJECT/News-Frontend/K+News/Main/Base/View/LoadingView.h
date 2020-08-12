
//
//  LoadingView.h
//  News
//
//  Created by tplish on 2019/12/20.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef LoadingView_h
#define LoadingView_h

#import <UIKit/UIKit.h>

@interface LoadingView : UIButton

- (void)startLoading;
- (void)stopLoading;
- (BOOL)isAnimating;

@end

#endif /* LoadingView_h */
