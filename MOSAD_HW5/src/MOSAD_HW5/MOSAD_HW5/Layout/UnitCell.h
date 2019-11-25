//
//  UnitCell.h
//  MOSAD_HW5
//
//  Created by 梁俊华 on 2019/11/2.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#ifndef UnitCell_h
#define UnitCell_h
#import <UIKit/UIKit.h>

@interface UnitCell : UICollectionViewCell

@property (strong, nonatomic) UILabel * label;

- (void)setUnitText:(NSString *)tex;

@end

#endif /* UnitCell_h */
