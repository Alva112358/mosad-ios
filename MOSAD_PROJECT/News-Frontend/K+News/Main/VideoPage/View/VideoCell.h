//
//  videoCell.h
//  News
//
//  Created by 梁俊华 on 2019/12/21.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef videoCell_h
#define videoCell_h
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "RHPlayerView.h"

@interface VideoCell : UITableViewCell
@property (strong, nonatomic) UIImageView * img;
@property (strong, nonatomic) UILabel * title;
@property (strong, nonatomic) UIButton * loveBtn;
@property (strong, nonatomic) UIButton * comBtn;
@property (strong, nonatomic) UIButton * playButton;
@property (strong, nonatomic) UIView * buttonView;
@property (strong, nonatomic) RHVideoModel * video;
@property (strong, nonatomic) RHPlayerView * player;

- (void)setupUIWithTitle:(NSString *)name
               WithImage:(NSString *)imgURL
                WithGood:(NSString *)goodNum
             WithComment:(NSString *)commentNum
               WithVideo:(RHVideoModel *)video
              WithPlayer:(RHPlayerView *)player;

@end

#endif /* videoCell_h */
