//
//  UIColor+Hex.m
//  News
//
//  Created by tplish on 2019/12/21.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color aplha:(CGFloat)alpha{
    // delete the space
    NSString * cStr =[[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] uppercaseString];
    
    if (cStr.length < 6){
        return UIColor.clearColor;
    }
    
    if ([cStr hasPrefix:@"0x"] || [cStr hasPrefix:@"0X"]){
        cStr = [cStr substringFromIndex:2];
    }
    
    if ([cStr hasPrefix:@"#"]){
        cStr = [cStr substringFromIndex:1];
    }
    
    if (cStr.length != 6){
        return UIColor.clearColor;
    }
    
    NSRange range;
    range.length = 2;
    
    range.location = 0; NSString * rStr = [cStr substringWithRange:range];
    range.location = 2; NSString * gStr = [cStr substringWithRange:range];
    range.location = 4; NSString * bStr = [cStr substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)color{
    return [self colorWithHexString:color aplha:1.0f];
}



@end
