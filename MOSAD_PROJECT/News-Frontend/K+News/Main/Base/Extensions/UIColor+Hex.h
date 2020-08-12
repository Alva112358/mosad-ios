//
//  UIColor+Hex.h
//  News
//
//  Created by tplish on 2019/12/21.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef UIColor_Hex_h
#define UIColor_Hex_h

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color aplha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;

@end

#endif /* UIColor_Hex_h */
