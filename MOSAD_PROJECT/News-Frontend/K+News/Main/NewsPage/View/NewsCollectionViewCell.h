//
//  NewsCollectionViewCell.h
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef NewsCollectionViewCell_h
#define NewsCollectionViewCell_h

#import <UIKit/UIKit.h>
#import "../Model/NewsModel.h"

@interface NewsCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UIImageView * imageView;
@end

#endif /* NewsCollectionViewCell_h */
