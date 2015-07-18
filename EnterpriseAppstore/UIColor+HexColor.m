//
//  UIColor+HexColor.m
//  GAMECO
//
//  Created by hegaokun on 15/6/24.
//  Copyright (c) 2015年 cn.edu.ustc. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (UIColor *)colorWithHex:(NSString *)hex {
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    if (hex.length == 7) {
        range.location = 1;
    }
    [[NSScanner scannerWithString:[hex substringWithRange:range]]scanHexInt:&red];
    range.location += 2;
    [[NSScanner scannerWithString:[hex substringWithRange:range]]scanHexInt:&green];
    range.location += 2;
    [[NSScanner scannerWithString:[hex substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red / 255.0) green:(float)(green / 255.0) blue:(float)(blue / 255.0) alpha:1.0];
}

@end
