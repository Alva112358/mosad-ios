//
//  WaterFlowCell.m
//  News
//
//  Created by 梁俊华 on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Foundation/Foundation.h>
#import "ImageFlowCell.h"
#import "Masonry.h"

@interface ImageFlowCell() {
    
}

@end

@implementation ImageFlowCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // [self setBackgroundColor:[UIColor greenColor]];
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading.png"]];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
        [self setLayout];
    }
    return self;
}

- (void)setWithImage:(UIImage *)img {
//    CGSize newSize = CGSizeMake(197, 220);
//    UIGraphicsBeginImageContext(newSize);
//    [img drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    [self.imageView setImage:img];
}

- (void)setLayout {
    UIView * superview = self.contentView;
    
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superview.centerX);
        make.centerY.equalTo(superview.centerY);
    }];
}

@end
