//
//  StarUnit.m
//  MOSAD_HW5
//
//  Created by 梁俊华 on 2019/11/3.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Foundation/Foundation.h>
#import "StarUnit.h"
#import "Masonry.h"

@implementation StarUnit

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Star0.png"]];
        self.image.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.image];
        [self setLayout];
    }
    return self;
}

- (void)setLayout {
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [self.image.image drawInRect:imageRect];
    self.image.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIView * superview = self.contentView;
    
    [self.image makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superview.centerX);
        make.centerY.equalTo(superview.centerY);
    }];
}



@end
