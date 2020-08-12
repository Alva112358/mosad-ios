//
//  TabCollectionViewCell.m
//  News
//
//  Created by tplish on 2019/12/17.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabCollectionViewCell.h"
#import "Masonry.h"

@interface TabCollectionViewCell()

@end

@implementation TabCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self.contentView addSubview:self.label];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (UILabel *)label{
    if (_label == nil){
        _label = [[UILabel alloc] init];
        _label.font = [UIFont fontWithName:@"System" size:24];
        _label.textColor = UIColor.blackColor;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end
