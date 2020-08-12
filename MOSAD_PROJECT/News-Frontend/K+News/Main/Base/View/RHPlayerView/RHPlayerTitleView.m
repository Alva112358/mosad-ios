//
//  RHPlayerTitleView.m
//  MCSchool
//
//  Created by 郭人豪 on 2017/4/14.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "RHPlayerTitleView.h"
#import "Masonry.h"
#define Color_RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0  alpha:1.0]
#define Color_RGB_Alpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0  alpha:(a)]
#define Color_Random           [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0]

@interface RHPlayerTitleView ()

@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UILabel * titleLabel;

@end
@implementation RHPlayerTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = Color_RGB_Alpha(0, 0, 0, 0.4);
        [self addSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self makeConstraintsForUI];
}

#pragma mark - add subviews

- (void)addSubviews {
    
    [self addSubview:self.backButton];
    [self addSubview:self.titleLabel];
}

#pragma mark - make constraints

- (void)makeConstraintsForUI {
        
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@30);
        make.top.mas_equalTo(@0);
        make.left.mas_equalTo(@10);
        make.bottom.mas_equalTo(@0);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(@0);
        make.left.mas_equalTo(@45);
        make.bottom.mas_equalTo(@0);
        make.right.mas_equalTo(@-15);
    }];
}

- (void)showBackButton {
    
    _backButton.hidden = NO;
}

- (void)hideBackButton {
    
    _backButton.hidden = YES;
}

#pragma mark - button event

- (void)clickBackButton:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleViewDidExitFullScreen:)]) {
        
        [self.delegate titleViewDidExitFullScreen:self];
    }
}

#pragma mark - setter and getter

- (UIButton *)backButton {
    
    if (!_backButton) {
        
        UIButton * backButton = [[UIButton alloc] init];
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
        backButton.hidden = YES;
        _backButton = backButton;
    }
    return _backButton;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    _titleLabel.text = _title;
}

@end
