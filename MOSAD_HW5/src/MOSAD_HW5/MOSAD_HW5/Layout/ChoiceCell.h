//
//  ChoiceCell.h
//  MOSAD_HW5
//
//  Created by 梁俊华 on 2019/11/2.
//  Copyright © 2019 梁俊华. All rights reserved.
//

#ifndef ChoiceCell_h
#define ChoiceCell_h
#import <UIKit/UIKit.h>

@interface ChoiceCell : UICollectionViewCell

@property (strong, nonatomic) UILabel * word;

- (void)setWithWord:(NSString *)word;

- (void)setTextColor:(UIColor *)textColor;

@end


#endif /* ChoiceCell_h */
