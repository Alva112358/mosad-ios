//
//  MyCollectionViewCell.m
//  16340129梁俊华
//
//  Created by 梁俊华 on 2019/9/28.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Foundation/Foundation.h>
#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

@synthesize image = _image;
@synthesize label = _label;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)setCellWithImage:(UIImage *)img
                withText:(NSString *)tex {
    // 添加图片
    _image = [[UIImageView alloc] initWithImage:img];
    
    
    // 添加文字
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    _label.text = tex;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont systemFontOfSize:18];

    [self.contentView addSubview:_image];
    [self.contentView addSubview:_label];
    
    [self setupLayout];
}

- (void)setupLayout {
    UIView * superview = self.contentView;
    [_label makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superview.centerX);
    }];
    
    [_image makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_label.bottom).offset(10);
        make.centerX.equalTo(superview.centerX);
    }];
    //[self.contentView layoutIfNeeded];
}
    
@end


