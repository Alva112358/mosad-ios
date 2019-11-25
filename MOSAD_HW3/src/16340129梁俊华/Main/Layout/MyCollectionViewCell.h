//
//  MyCollectionViewCell.h
//  16340129梁俊华
//
//  Created by 梁俊华 on 2019/9/28.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#ifndef MyCollectionViewCell_h
#define MyCollectionViewCell_h
#import "UIKit/UIKit.h"
#import "Masonry.h"

@interface MyCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView * image;

@property (strong, nonatomic) UILabel * label;

- (void)setCellWithImage:(UIImage *)img withText:(NSString *)tex;

@end

#endif /* MyCollectionViewCell_h */
