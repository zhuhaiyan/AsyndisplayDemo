//
//  UIColor+J.m
//  JKitDemo
//
//  Created by elongtian on 16/1/5.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "UIColor+J.h"

@implementation UIColor (J)
#pragma mark 16进制转为UIColor

+ (UIColor *)j_colorWithHex:(NSUInteger)hex
{
    return [UIColor j_colorWithHex:hex alpha:1.0];
}

+ (UIColor *)j_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:alpha];
}

#pragma mark 16进制字符串转为UIColor

+ (UIColor *)j_colorWithHexString:(NSString *)hexString
{
    if (![hexString isKindOfClass:[NSString class]] || [hexString length] == 0) {
        
        return [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    }
    
    const char *s = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
    
    if (*s == '#') {
        ++s;
    }
    
    unsigned long long value = strtoll(s, nil, 16);
    int r, g, b, a;
    
    switch (strlen(s)) {
        case 2:
            // xx
            r = g = b = (int)value;
            a = 255;
            break;
        case 3:
            // RGB
            r = ((value & 0xf00) >> 8);
            g = ((value & 0x0f0) >> 4);
            b = ((value & 0x00f) >> 0);
            r = r * 16 + r;
            g = g * 16 + g;
            b = b * 16 + b;
            a = 255;
            break;
        case 6:
            // RRGGBB
            r = (value & 0xff0000) >> 16;
            g = (value & 0x00ff00) >>  8;
            b = (value & 0x0000ff) >>  0;
            a = 255;
            break;
        default:
            // RRGGBBAA
            r = (value & 0xff000000) >> 24;
            g = (value & 0x00ff0000) >> 16;
            b = (value & 0x0000ff00) >>  8;
            a = (value & 0x000000ff) >>  0;
            break;
    }
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a / 255.0f];
}

#pragma mark 产生随机颜色
+ (UIColor *)j_colorWithRamdom {
    
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0f green:arc4random_uniform(256) / 255.0f blue:arc4random_uniform(256) / 255.0f alpha:1.0f];
}

#pragma mark -translucent 相关颜色
- (UIColor *)j_changeFromTranslucent {
    
    CGFloat red, green, blue, alpha;
    
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    
    CGFloat opacity = 0.4f;
    
    CGFloat minVal = MIN(MIN(red, green), blue);
    
    if ([self convertValue:minVal withOpacity:opacity] < 0) {
        
        opacity = [self minOpacityForValue:minVal];
    }
    
    red = [self convertValue:red withOpacity:opacity];
    
    green = [self convertValue:green withOpacity:opacity];
    
    blue = [self convertValue:blue withOpacity:opacity];
    
    red = MAX(MIN(1.0, red), 0);
    
    green = MAX(MIN(1.0, green), 0);
    
    blue = MAX(MIN(1.0, blue), 0);
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];

}
- (CGFloat)minOpacityForValue:(CGFloat)value {
    
    return (0.4 - 0.4 * value) / (0.6 * value + 0.4);
}
- (CGFloat)convertValue:(CGFloat)value withOpacity:(CGFloat)opacity {
    
    return 0.4 * value / opacity + 0.6 * value - 0.4 / opacity + 0.4;
}
@end
