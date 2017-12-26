//
//  UIColor+J.h
//  JKitDemo
//
//  Created by elongtian on 16/1/5.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JColorWithHex(hex) [UIColor j_colorWithHex:hex]
#define JColorWithHexAlpha(hex,a) [UIColor j_colorWithHex:hex alpha:a]
#define JColorWithHexString(hexString) [UIColor j_colorWithHexString:hexString]
#define JColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define JColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

#define JColorWithClear [UIColor clearColor]
#define JColorWithBlack [UIColor blackColor]
#define JColorWithWhite [UIColor whiteColor]
#define JColorWithRed [UIColor redColor]
#define JColorWithGray [UIColor grayColor]

#define JRandomColor [UIColor j_colorWithRamdom]


@interface UIColor (J)

/**
 translucent barTintColor YES -> NO   translucent为 YES 时，颜色也随着半透明了。

 @return 真实颜色
 */
- (UIColor *)j_changeFromTranslucent;

/**
 *  16进制转为UIColor
 *
 *  @param hex 16进制数
 *
 *  @return UIColor
 */
+ (UIColor *)j_colorWithHex:(NSUInteger)hex;

/**
 *  16进制转为UIColor
 *
 *  @param hex   16进制数
 *  @param alpha 透明度
 *
 *  @return UIColor
 */
+ (UIColor *)j_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;

/**
 *  16进制字符串转为UIColor
 *
 *  @param hexString e.g.@"ff", @"#fff", @"ff0000",  @"ff00ffcc"
 *
 *  @return UIColor
 */
+ (UIColor *)j_colorWithHexString:(NSString *)hexString;

/**
 *  产生随机颜色
 *
 *  @return 随机色
 */
+ (UIColor *)j_colorWithRamdom;
@end
