//
//  ImageCell.h
//  MOSAD_HW6
//
//  Created by 梁俊华 on 2019/11/24.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#ifndef MyCollectionViewCell_h
#define MyCollectionViewCell_h
#import "UIKit/UIKit.h"
#import "Masonry.h"

@interface ImageCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView * image;

- (void)setWithImage:(UIImage *)img;

@end


#endif /* ImageCell_h */
