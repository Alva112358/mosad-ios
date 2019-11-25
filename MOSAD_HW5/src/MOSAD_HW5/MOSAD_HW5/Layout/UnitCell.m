//
//  UnitCell.m
//  MOSAD_HW5
//
//  Created by 梁俊华 on 2019/11/2.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import <Foundation/Foundation.h>
#import "UnitCell.h"
#import "Masonry.h"

@implementation UnitCell

@synthesize label = _label;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)setUnitText:(NSString *)tex {
    _label = [[UILabel alloc] init];
    _label.text = tex;
    _label.textColor = UIColor.whiteColor;
    _label.font = [UIFont systemFontOfSize:20];
    
    [self.contentView addSubview:_label];
    [self setLayout];
}

- (void)setLayout {
    UIView * superview = self.contentView;
    
    [_label makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superview.centerX);
        make.centerY.equalTo(superview.centerY);
    }];
    
    [self setGradientColor];
}

- (void)setGradientColor {
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    
    [self drawRect:self.frame];
    [self.contentView.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.contentView.layer.cornerRadius = self.contentView.bounds.size.width * 0.08;
    self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.contentView.layer.borderWidth = 0.1;
    self.contentView.layer.masksToBounds =  YES;
}

@end
