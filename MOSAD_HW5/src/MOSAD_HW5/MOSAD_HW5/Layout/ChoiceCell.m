//
//  ChoiceCell.m
//  MOSAD_HW5
//
//  Created by 梁俊华 on 2019/11/2.
//  Copyright © 2019 梁俊华. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import <Foundation/Foundation.h>
#import "ChoiceCell.h"
#import "Masonry.h"

@implementation ChoiceCell

@synthesize word = _word;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _word = [[UILabel alloc] init];
    }
    return self;
}

- (void)setWithWord:(NSString *)word {
    _word.text = word;
    _word.textColor = UIColor.blackColor;
    _word.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_word];
    [self setLayout];
}

- (void)setLayout {
    UIView * superview = self.contentView;
    
    [_word makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superview.centerX);
        make.centerY.equalTo(superview.centerY);
    }];
}

- (void)setTextColor:(UIColor *)textColor {
    _word.textColor = textColor;
}

@end
