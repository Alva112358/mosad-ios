//
//  VideoCell.m
//  News
//
//  Created by 梁俊华 on 2019/12/21.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoCell.h"

@interface VideoCell() {
    NSString * ImgURL;
    NSString * GoodNum;
    NSString * CommentNum;
    NSInteger isLike;
}

@end

@implementation VideoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
        [self makeConstricted];
        isLike = 0;
    }
    return self;
}

- (void)setupUIWithTitle:(NSString *)name
               WithImage:(NSString *)imgURL
                WithGood:(NSString *)goodNum
             WithComment:(NSString *)commentNum
               WithVideo:(RHVideoModel *)video
              WithPlayer:(RHPlayerView *)player {
    NSData * imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]];
    UIImage * img = [UIImage imageWithData:imgData];
    [self.title setText:name];
    
    self.video = video;
    self.player = player;
    GoodNum = goodNum;
    ImgURL = imgURL;
    CommentNum = commentNum;
    //NSLog(@"VideoCell, number of Goods = %@", GoodNum);
    [_loveBtn setTitle:GoodNum forState:UIControlStateNormal];
    [_comBtn setTitle:CommentNum forState:UIControlStateNormal];
    
    CGSize newSize = CGSizeMake(70, 70);
    UIGraphicsBeginImageContext(newSize);
    [img drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.img setImage:newImage];
}

- (void)addSubviews {
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.img];
    [self.contentView addSubview:self.buttonView];
    [self.buttonView addSubview:self.comBtn];
    [self.buttonView addSubview:self.loveBtn];
    [self.buttonView addSubview:self.playButton];
}

- (void)makeConstricted {
    UIView * superview = self.contentView;
    [_title makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.left).offset(10);
        make.top.equalTo(superview.top).offset(10);
    }];
    
    [_img makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.left).offset(10);
        make.top.equalTo(superview.top).offset(40);
    }];
}

#pragma mark - GetterAndSetter
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _title.text = @"Hello";
        _title.font = [UIFont systemFontOfSize:20];
        
        // [_title setBackgroundColor:[UIColor greenColor]];
        [_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    }
    return _title;
}

- (UIButton *)loveBtn {
    if (!_loveBtn) {
        _loveBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 60, 30)];
//        _loveBtn.showsTouchWhenHighlighted = YES;
//        _loveBtn.layer.borderWidth = 0.2;
//        _loveBtn.layer.cornerRadius = 7.0f;
//        _loveBtn.layer.masksToBounds = YES;
        [_loveBtn setImage:[UIImage imageNamed:@"Good1.png"] forState:UIControlStateNormal];
        [_loveBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, -_loveBtn.imageView.bounds.size.width + 25, 5, 0)];
        [_loveBtn setImageEdgeInsets:UIEdgeInsetsMake(5, -5, 5, 0)];
//        [_loveBtn setBackgroundColor:[UIColor colorWithRed:102 / 255.0 green:199 / 255.0 blue:90 / 255.0 alpha:1]];
        [_loveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loveBtn addTarget:self action:@selector(makeGood) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveBtn;
}

- (UIButton *)comBtn {
    if (!_comBtn) {
        _comBtn = [[UIButton alloc] initWithFrame:CGRectMake(170, 10, 60, 30)];
//        _comBtn.showsTouchWhenHighlighted = YES;
//        _comBtn.layer.borderWidth = 0.2;
//        _comBtn.layer.cornerRadius = 7.0f;
//        _comBtn.layer.masksToBounds = YES;
        [_comBtn setImage:[UIImage imageNamed:@"Comment.png"] forState:UIControlStateNormal];
        [_comBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, -_comBtn.imageView.bounds.size.width + 30, 5, 0)];
        [_comBtn setImageEdgeInsets:UIEdgeInsetsMake(5, -5, 5, 0)];
//        [_comBtn setBackgroundColor:[UIColor colorWithRed:102 / 255.0 green:199 / 255.0 blue:90 / 255.0 alpha:1]];
        [_comBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _comBtn;
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
//        _playButton.showsTouchWhenHighlighted = YES;
//        _playButton.layer.borderWidth = 0.2;
//        _playButton.layer.cornerRadius = 7.0f;
//        _playButton.layer.masksToBounds = YES;
        [_playButton setImage:[UIImage imageNamed:@"play.png"] forState:0];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // [_playButton setBackgroundColor:[UIColor colorWithRed:102 / 255.0 green:199 / 255.0 blue:90 / 255.0 alpha:1]];
        [_playButton setTitleEdgeInsets:UIEdgeInsetsMake(5, -_playButton.imageView.bounds.size.width + 30, 5, 0)];
        [_playButton setImageEdgeInsets:UIEdgeInsetsMake(5, -5, 5, 0)];
        [_playButton addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}


- (UIImageView *)img {
    if (!_img) {
        _img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 70, 70)];
        [_img setBackgroundColor:[UIColor blueColor]];
    }
    return _img;
}

- (UIView *)buttonView {
    if (!_buttonView) {
        _buttonView = [[UIView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 240, 75, 230, 50)];
        // [_buttonView setBackgroundColor:[UIColor greenColor]];
    }
    return _buttonView;
}

#pragma mark - ButtonMethod
- (void)playVideo {
    [self.player playVideoWithVideoId:self.video.videoId];
}

- (void)makeGood {
    if (isLike == 0) {
        [_loveBtn setImage:[UIImage imageNamed:@"Good2"] forState:UIControlStateNormal];
        NSInteger num = [GoodNum intValue];
        num = num + 1;
        NSString * newNum = [NSString stringWithFormat:@"%ld", num];
        GoodNum = newNum;
        [_loveBtn setTitle:newNum forState:UIControlStateNormal];
        isLike = 1;
    } else {
        [_loveBtn setImage:[UIImage imageNamed:@"Good1"] forState:UIControlStateNormal];
        NSInteger num = [GoodNum intValue];
        num = num - 1;
        NSString * newNum = [NSString stringWithFormat:@"%ld", num];
        GoodNum = newNum;
        [_loveBtn setTitle:newNum forState:UIControlStateNormal];
        isLike = 0;
    }
}

@end
