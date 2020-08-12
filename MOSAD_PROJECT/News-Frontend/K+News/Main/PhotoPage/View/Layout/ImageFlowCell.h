//
//  WaterFlowCell.h
//  News
//
//  Created by 梁俊华 on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef WaterFlowCell_h
#define WaterFlowCell_h
#import <UIKit/UIKit.h>

@interface ImageFlowCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView * imageView;

- (void)setWithImage:(UIImage *)img;

@end


#endif /* WaterFlowCell_h */
