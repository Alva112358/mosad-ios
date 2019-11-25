//
//  ImageCell.m
//  MOSAD_HW6
//
//  Created by 梁俊华 on 2019/11/24.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Foundation/Foundation.h>
#import "ImageCell.h"

@implementation ImageCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [[UIImageView alloc] init];
    }
    return self;
}

- (void)setWithImage:(UIImage *)img {
    self.image.image = [self scaleImage:img toScale:0.4];//[[UIImageView alloc] initWithImage:img];
    self.clipsToBounds = YES;

    [self.contentView addSubview:self.image];

    [self.image makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.centerX);
    }];

    // self.backgroundColor = [UIColor yellowColor];
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
