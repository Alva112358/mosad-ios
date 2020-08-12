//
//  NewsCollectionViewCell.m
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsCollectionViewCell.h"
#import "Masonry.h"

@interface NewsCollectionViewCell()

@end

@implementation NewsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        
        self.contentView.layer.cornerRadius = 20;
        self.contentView.backgroundColor = UIColor.whiteColor;
        
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.imageView];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.width.mas_equalTo(self.contentView).mas_offset(-20);
            make.height.mas_equalTo(80);
        }];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.label.mas_bottom);
        }];
    }
    return self;
}

- (UILabel *)label{
    if (_label == nil){
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:24];
        _label.textColor = UIColor.blackColor;
        _label.textAlignment = NSTextAlignmentLeft;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        _label.numberOfLines = 0;
        _label.preferredMaxLayoutWidth = CGRectGetWidth(self.contentView.frame);
    }
    return _label;
}

- (UIImageView *)imageView{
    if (_imageView == nil){
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = UIColor.whiteColor;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.layer.cornerRadius = 20;
    }
    return _imageView;
}




@end
