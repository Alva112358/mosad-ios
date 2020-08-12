//
//  UITextField+Underline.m
//  News
//
//  Created by tplish on 2019/12/21.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYTextField.h"

@interface MYTextField()

@end

@implementation MYTextField

- (void)drawRect:(CGRect)rect{
    
    CAGradientLayer * gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1);
    gl.colors = @[(id)[UIColor.systemPinkColor colorWithAlphaComponent:0].CGColor,
                  (id)[UIColor.systemPinkColor colorWithAlphaComponent:1].CGColor,
                  (id)[UIColor.systemPinkColor colorWithAlphaComponent:0].CGColor];
    gl.locations = @[@0, @0.5, @1];
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 0);
    gl.cornerRadius = 10;
    
    [self.layer addSublayer:gl];
}

@end
